// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import '../models/observation.dart';

class DetailObservationScreen extends StatelessWidget {
  const DetailObservationScreen({super.key});

  Future<void> _ouvrirFormulaire(BuildContext context, Observation obs) async {
    final modifiee = await Navigator.pushNamed(
      context,
      '/formulaire',
      arguments: obs,
    ) as Observation?;
    if (modifiee != null && context.mounted) {
      Navigator.pop(context, modifiee);
    }
  }

  Widget _buildImage(Observation obs) {
    if (obs.imageBytes != null) {
      return Image.memory(obs.imageBytes!, fit: BoxFit.cover);
    }
    if (obs.imagePath != null) {
      return Image.asset(obs.imagePath!, fit: BoxFit.cover);
    }
    return Container(
      color: obs.type == TypeEspece.faune
          ? Colors.orange.shade100
          : Colors.green.shade100,
      child: Icon(
        obs.type == TypeEspece.faune ? Icons.pets : Icons.park,
        size: 80,
        color: obs.type == TypeEspece.faune ? Colors.orange : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final obs = ModalRoute.of(context)!.settings.arguments as Observation;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFFf7f4e1),
            foregroundColor: const Color(0xFF012d1d),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => _ouvrirFormulaire(context, obs),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => Navigator.pushNamed(context, '/apropos'),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImage(obs),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xFFfdfae7), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  if (obs.menacee)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFba1a1a),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'CRITIQUEMENT MENACÉE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    obs.nom,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: const Color(0xFF012d1d)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    obs.type == TypeEspece.faune ? 'Faune' : 'Flore',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF414844),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _Carte(
                    titre: 'DÉTAILS DE L\'OBSERVATION',
                    couleurTitre: const Color(0xFF75593a),
                    enfants: [
                      _LigneDetail(
                        label: 'DATE',
                        valeur:
                            '${obs.date.day.toString().padLeft(2, '0')}/'
                            '${obs.date.month.toString().padLeft(2, '0')}/'
                            '${obs.date.year}',
                      ),
                      _LigneDetail(label: 'LOCALISATION', valeur: obs.parc),
                      _LigneDetail(
                        label: 'TYPE',
                        valeur: obs.type == TypeEspece.faune
                            ? '🐾 Faune'
                            : '🌿 Flore',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _Carte(
                    titre: 'CONSERVATION',
                    couleurTitre: const Color(0xFFba1a1a),
                    enfants: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Icon(
                              obs.menacee
                                  ? Icons.warning_rounded
                                  : Icons.check_circle_outline,
                              size: 40,
                              color: obs.menacee
                                  ? const Color(0xFFba1a1a)
                                  : Colors.green,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              obs.menacee
                                  ? 'Espèce menacée'
                                  : 'Espèce non menacée',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: obs.menacee
                                    ? const Color(0xFFba1a1a)
                                    : Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _ouvrirFormulaire(context, obs),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Modifier l\'observation'),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Carte extends StatelessWidget {
  final String titre;
  final Color couleurTitre;
  final List<Widget> enfants;

  const _Carte({
    required this.titre,
    required this.couleurTitre,
    required this.enfants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFc1c8c2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: couleurTitre.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Text(
              titre,
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: couleurTitre,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: enfants,
            ),
          ),
        ],
      ),
    );
  }
}

class _LigneDetail extends StatelessWidget {
  final String label;
  final String valeur;

  const _LigneDetail({required this.label, required this.valeur});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF414844),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            valeur,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1c1c11),
            ),
          ),
        ],
      ),
    );
  }
}