// lib/screens/formulaire_screen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import '../models/observation.dart';

class FormulaireObservationScreen extends StatefulWidget {
  const FormulaireObservationScreen({super.key});

  @override
  State<FormulaireObservationScreen> createState() =>
      _FormulaireObservationState();
}

class _FormulaireObservationState
    extends State<FormulaireObservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController  = TextEditingController();
  final _parcController = TextEditingController();

  TypeEspece _type    = TypeEspece.faune;
  DateTime   _date    = DateTime.now();
  bool       _menacee = false;

  // ── Gestion image ─────────────────────────────────────────────
  Uint8List? _imageBytes;   // image choisie en mémoire
  String?    _imagePath;    // chemin asset existant (mode édition)

  Observation? _observationExistante;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is Observation && _observationExistante == null) {
      _observationExistante = arg;
      _nomController.text  = arg.nom;
      _parcController.text = arg.parc;
      _type    = arg.type;
      _date    = arg.date;
      _menacee = arg.menacee;
      _imagePath = arg.imagePath; // récupère l'image existante
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _parcController.dispose();
    super.dispose();
  }

  // ── Choisir une photo depuis la galerie ───────────────────────
  Future<void> _choisirPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imagePath  = null; // on utilise les bytes, pas l'asset
      });
    }
  }

  Future<void> _choisirDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _soumettre() {
    if (!_formKey.currentState!.validate()) return;

    final observation = _observationExistante == null
        ? Observation(
            nom     : _nomController.text.trim(),
            type    : _type,
            parc    : _parcController.text.trim(),
            date    : _date,
            menacee : _menacee,
            imagePath: _imagePath,
            imageBytes: _imageBytes,
          )
        : _observationExistante!.copyWith(
            nom     : _nomController.text.trim(),
            type    : _type,
            parc    : _parcController.text.trim(),
            date    : _date,
            menacee : _menacee,
            imagePath: _imagePath,
            imageBytes: _imageBytes,
          );

    Navigator.pop(context, observation);
  }

  @override
  Widget build(BuildContext context) {
    final estModification = _observationExistante != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(estModification
            ? 'Modifier l\'observation'
            : 'Nouvelle observation'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            // ── Sélecteur de photo ────────────────────────────
            GestureDetector(
              onTap: _choisirPhoto,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFf1eedb),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFc1c8c2)),
                ),
                child: _imageBytes != null
                    // Photo choisie depuis galerie
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          _imageBytes!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : _imagePath != null
                        // Photo existante (asset)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              _imagePath!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        // Placeholder
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_a_photo_outlined,
                                  size: 40, color: Color(0xFF414844)),
                              SizedBox(height: 8),
                              Text(
                                'Ajouter une photo',
                                style: TextStyle(
                                  fontFamily: 'Work Sans',
                                  color: Color(0xFF414844),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
              ),
            ),
            if (_imageBytes != null || _imagePath != null)
              TextButton.icon(
                onPressed: _choisirPhoto,
                icon: const Icon(Icons.refresh),
                label: const Text('Changer la photo'),
              ),
            const SizedBox(height: 20),

            // ── Nom ───────────────────────────────────────────
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(
                labelText: 'NOM DE L\'ESPÈCE',
                hintText: 'ex: Lion d\'Afrique',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Le nom est obligatoire';
                }
                if (v.trim().length < 3) {
                  return 'Minimum 3 caractères';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // ── Type ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFc1c8c2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TYPE D\'ORGANISME',
                      style: TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF414844),
                      )),
                  const SizedBox(height: 12),
                  Row(
                    children: TypeEspece.values.map((t) {
                      final actif = _type == t;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _type = t),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12),
                              decoration: BoxDecoration(
                                color: actif
                                    ? const Color(0xFF012d1d)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: actif
                                      ? const Color(0xFF012d1d)
                                      : const Color(0xFFc1c8c2),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    t == TypeEspece.faune
                                        ? Icons.pets
                                        : Icons.park,
                                    size: 18,
                                    color: actif
                                        ? Colors.white
                                        : const Color(0xFF414844),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    t == TypeEspece.faune
                                        ? 'Faune'
                                        : 'Flore',
                                    style: TextStyle(
                                      fontFamily: 'Work Sans',
                                      fontWeight: FontWeight.w600,
                                      color: actif
                                          ? Colors.white
                                          : const Color(0xFF414844),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Parc ──────────────────────────────────────────
            TextFormField(
              controller: _parcController,
              decoration: const InputDecoration(
                labelText: 'PARC NATIONAL',
                hintText: 'ex: Niokolo-Koba',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Le parc est obligatoire';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // ── Date ──────────────────────────────────────────
            GestureDetector(
              onTap: _choisirDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFc1c8c2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('DATE D\'OBSERVATION',
                            style: TextStyle(
                              fontFamily: 'JetBrains Mono',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF414844),
                            )),
                        const SizedBox(height: 4),
                        Text(
                          '${_date.day.toString().padLeft(2, '0')}/'
                          '${_date.month.toString().padLeft(2, '0')}/'
                          '${_date.year}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.calendar_today_outlined,
                        color: Color(0xFF414844)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Menacée ───────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFffdad6).withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFc1c8c2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_outlined,
                      color: Color(0xFFba1a1a), size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Conservation',
                            style: TextStyle(
                              fontFamily: 'JetBrains Mono',
                              fontSize: 11,
                              color: Color(0xFF414844),
                            )),
                        Text('Espèce menacée ?',
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFba1a1a),
                            )),
                      ],
                    ),
                  ),
                  Switch(
                    value: _menacee,
                    onChanged: (val) => setState(() => _menacee = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ── Bouton enregistrer ────────────────────────────
            FilledButton.icon(
              onPressed: _soumettre,
              icon: const Icon(Icons.save_outlined),
              label: Text(estModification
                  ? 'Enregistrer les modifications'
                  : 'Enregistrer l\'observation'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}