// lib/services/storage_service.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/observation.dart';

class StorageService {
  static const _key = 'observations';

  // ── Sauvegarder la liste ─────────────────────────────────────
  static Future<void> sauvegarder(List<Observation> liste) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = liste.map((o) => {
      'nom'       : o.nom,
      'type'      : o.type.name,
      'parc'      : o.parc,
      'date'      : o.date.toIso8601String(),
      'menacee'   : o.menacee,
      'imagePath' : o.imagePath,
      'imageBytes': o.imageBytes != null
          ? base64Encode(o.imageBytes!)
          : null,
    }).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  // ── Charger la liste ─────────────────────────────────────────
  static Future<List<Observation>?> charger() async {
    final prefs = await SharedPreferences.getInstance();
    final json  = prefs.getString(_key);
    if (json == null) return null;

    final jsonList = jsonDecode(json) as List;
    return jsonList.map((j) => Observation(
      nom      : j['nom'],
      type     : TypeEspece.values.byName(j['type']),
      parc     : j['parc'],
      date     : DateTime.parse(j['date']),
      menacee  : j['menacee'],
      imagePath: j['imagePath'],
      imageBytes: j['imageBytes'] != null
          ? base64Decode(j['imageBytes'])
          : null,
    )).toList();
  }
}