import 'package:flutter/material.dart';
import '../models/observation.dart';

class ObservationCard extends StatelessWidget {
  final Observation observation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ObservationCard({
    super.key,
    required this.observation,
    required this.onTap,
    required this.onDelete,
  });

  IconData get _icone {
    switch (observation.type) {
      case TypeEspece.faune:
        return Icons.pets;
      case TypeEspece.flore:
        return Icons.park;
    }
  }

  Color get _couleur {
    switch (observation.type) {
      case TypeEspece.faune:
        return Colors.orange;
      case TypeEspece.flore:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(

        // ── Image ou icône selon imagePath ───────────────────
       leading: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: observation.imageBytes != null
      ? Image.memory(
          observation.imageBytes!,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
        )
      : observation.imagePath != null
          ? Image.asset(
              observation.imagePath!,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            )
          : Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _couleur.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_icone, color: _couleur),
            ),
),

        // ── Nom de l'espèce ──────────────────────────────────
        title: Text(
          observation.nom,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),

        // ── Parc + date ──────────────────────────────────────
        subtitle: Text(
          '${observation.parc} · '
          '${observation.date.day.toString().padLeft(2, '0')}/'
          '${observation.date.month.toString().padLeft(2, '0')}/'
          '${observation.date.year}',
        ),

        // ── Badge + bouton supprimer ─────────────────────────
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (observation.menacee) const BadgeMenacee(),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: onDelete,
            ),
          ],
        ),

        onTap: onTap,
      ),
    );
  }
}

// ── Widget BadgeMenacee ──────────────────────────────────────────
class BadgeMenacee extends StatelessWidget {
  const BadgeMenacee({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        'Menacée',
        style: TextStyle(
          fontSize: 11,
          color: Colors.red.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}