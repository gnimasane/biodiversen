import 'package:flutter/material.dart';
import '../models/observation.dart';

class ObservationCard extends StatelessWidget {
  final Observation observation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  // Map des images pour chaque espèce
  static const Map<String, String> _images = {
    'Lion d\'Afrique': '🦁',
    'Hippotrague rouanne': '🦌',
    'Lamantin d\'Afrique': '🐋',
    'Rônier': '🌴',
    'Vétiver': '🌿',
  };

  const ObservationCard({
    super.key,
    required this.observation,
    required this.onTap,
    required this.onDelete,
  });

  // ── Couleur selon le type ─────────────────────────────────────
  Color get _couleurType {
    switch (observation.type) {
      case TypeEspece.faune:
        return const Color(0xFF75593a); // Savanna Sand
      case TypeEspece.flore:
        return const Color(0xFF3d1e07); // Earth Bark
    }
  }

  // ── Icône selon le type ──────────────────────────────────────
  IconData get _iconeType {
    switch (observation.type) {
      case TypeEspece.faune:
        return Icons.pets;
      case TypeEspece.flore:
        return Icons.forest;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: const Color(0xFFc1c8c2),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // ── Header coloré selon le type ──────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                color: _couleurType.withOpacity(0.12),
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFc1c8c2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _iconeType,
                    size: 16,
                    color: _couleurType,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    observation.type.name.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _couleurType,
                      letterSpacing: 0.05,
                    ),
                  ),
                ],
              ),
            ),

            // ── Contenu principal ────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // ── Avatar circulaire ───────────────────────────
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _couleurType.withOpacity(0.1),
                      border: Border.all(
                        color: const Color(0xFFc1c8c2),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _images[observation.nom] ?? '🦁',
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // ── Info texte ──────────────────────────────────
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nom de l'espèce
                        Text(
                          observation.nom,
                          style: const TextStyle(
                            fontFamily: 'Source Serif 4',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1c1c11),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Parc + date
                        Text(
                          '${observation.parc} • '
                          '${observation.date.day.toString().padLeft(2, '0')}/'
                          '${observation.date.month.toString().padLeft(2, '0')}/'
                          '${observation.date.year}',
                          style: const TextStyle(
                            fontFamily: 'Work Sans',
                            fontSize: 12,
                            color: Color(0xFF414844),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // ── Badge menacée + Actions ─────────────────────
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (observation.menacee)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFffdad6),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFba1a1a).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'MENACÉE',
                            style: TextStyle(
                              fontFamily: 'JetBrains Mono',
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF93000a),
                              letterSpacing: 0.05,
                            ),
                          ),
                        ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.delete_outline,
                              size: 18, color: Color(0xFFba1a1a)),
                          onPressed: onDelete,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget BadgeMenacee (pour les écrans détail) ────────────────
class BadgeMenacee extends StatelessWidget {
  const BadgeMenacee({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFffdad6),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFba1a1a).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: const Text(
        'MENACÉE',
        style: TextStyle(
          fontFamily: 'JetBrains Mono',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Color(0xFF93000a),
          letterSpacing: 0.05,
        ),
      ),
    );
  }
}
