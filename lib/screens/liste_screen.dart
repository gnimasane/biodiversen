import 'package:flutter/material.dart';
import '../models/observation.dart';
import '../widgets/observation_card.dart';
import '../data/observations_initiales.dart';
import '../services/storage_service.dart';

class ListeObservationsScreen extends StatefulWidget {
  const ListeObservationsScreen({super.key});

  @override
  State<ListeObservationsScreen> createState() => _ListeObservationsState();
}

class _ListeObservationsState extends State<ListeObservationsScreen> {
  TypeEspece? _filtre;
  late List<Observation> _observations;

  @override
  void initState() {
    super.initState();
    _observations = List.from(observationsInitiales);
    _chargerDonnees();
  }

  Future<void> _chargerDonnees() async {
    final sauvegardees = await StorageService.charger();
    if (sauvegardees != null) {
      setState(() => _observations = sauvegardees);
    }
  }

  int get _nombreMenacees => Observation.compterMenacees(_observations);

  List<Observation> get _observationsFiltrees {
    if (_filtre == null) return _observations;
    return _observations.where((o) => o.type == _filtre).toList();
  }

  void _ajouterObservation(Observation nouvelle) {
    setState(() => _observations.add(nouvelle));
    StorageService.sauvegarder(_observations);
  }

  void _supprimerObservation(Observation obs) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFfdfae7),
        title: const Text('Confirmer la suppression',
            style: TextStyle(
              fontFamily: 'Source Serif 4',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
        content: Text('Supprimer "${obs.nom}" ?',
            style: const TextStyle(fontFamily: 'Work Sans')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _observations.remove(obs));
              StorageService.sauvegarder(_observations);
            },
            child: const Text('Supprimer',
                style: TextStyle(
                    color: Color(0xFFba1a1a),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfdfae7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf7f4e1),
        elevation: 1,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 36,
            ),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Vie ',
                    style: TextStyle(
                      fontFamily: 'Source Serif 4',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF012d1d),
                    ),
                  ),
                  TextSpan(
                    text: 'Terrestre',
                    style: TextStyle(
                      fontFamily: 'Source Serif 4',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF75593a),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_nombreMenacees',
                    style: const TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFba1a1a),
                    ),
                  ),
                  const Text(
                    'Menacées',
                    style: TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFba1a1a),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Bannière verte ───────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF012d1d), Color(0xFF1b4332)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🌿 Protégeons la vie terrestre',
                    style: TextStyle(
                      fontFamily: 'Source Serif 4',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Recensement des espèces du Sénégal — ODD 15',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Filtres ──────────────────────────────────────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _boutonFiltre(null, 'TOUT'),
                const SizedBox(width: 8),
                _boutonFiltre(TypeEspece.faune, 'FAUNE'),
                const SizedBox(width: 8),
                _boutonFiltre(TypeEspece.flore, 'FLORE'),
              ],
            ),
          ),

          // ── Liste ────────────────────────────────────────────
          Expanded(
            child: _observationsFiltrees.isEmpty
                ? Center(
                    child: Text(
                      _filtre == null
                          ? 'Aucune observation'
                          : 'Aucune ${_filtre == TypeEspece.faune ? 'faune' : 'flore'}',
                      style: const TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 16,
                        color: Color(0xFF414844),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _observationsFiltrees.length,
                    itemBuilder: (context, index) {
                      final obs = _observationsFiltrees[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ObservationCard(
                          observation: obs,
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: obs,
                            );
                            if (result is Observation) {
                              setState(() {
                                final idx = _observations.indexOf(obs);
                                if (idx >= 0) _observations[idx] = result;
                              });
                              StorageService.sauvegarder(_observations);
                            }
                          },
                          onDelete: () => _supprimerObservation(obs),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF012d1d),
        onPressed: () async {
          final nouvelle = await Navigator.pushNamed(
            context,
            '/formulaire',
          ) as Observation?;
          if (nouvelle != null) _ajouterObservation(nouvelle);
        },
        child: const Icon(Icons.add, color: Color(0xFFFFFFFF)),
      ),
    );
  }

  Widget _boutonFiltre(TypeEspece? valeur, String label) {
    final actif = _filtre == valeur;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'JetBrains Mono',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: actif ? const Color(0xFFFFFFFF) : const Color(0xFF414844),
          letterSpacing: 0.05,
        ),
      ),
      selected: actif,
      backgroundColor: const Color(0xFFf1eedb),
      selectedColor: const Color(0xFF012d1d),
      side: BorderSide(
        color: actif ? const Color(0xFF012d1d) : const Color(0xFFc1c8c2),
      ),
      onSelected: (_) {
        setState(() => _filtre = valeur);
      },
    );
  }
}