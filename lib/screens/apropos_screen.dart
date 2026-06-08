import 'package:flutter/material.dart';

class AProposScreen extends StatelessWidget {
  const AProposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // ── Logo + titre ─────────────────────────────────────
          Row(
            children: [
              Image.asset('assets/images/logo.png', height: 56),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Vie Terrestre',
                    style: TextStyle(
                      fontFamily: 'Source Serif 4',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF012d1d),
                    ),
                  ),
                  Text(
                    'BiodiverSen',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 13,
                      color: Color(0xFF414844),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Description ──────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFf1eedb),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Application d\'inventaire de la faune et de la flore '
              'des aires protégées du Sénégal, dans le cadre de '
              'l\'ODD 15 — Vie terrestre.',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF1c1c11),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── Infos ─────────────────────────────────────────────
          const _LigneInfo(
            label: 'Auteur',
            valeur: 'Gnima Sane',
          ),
          const _LigneInfo(
            label: 'Promotion',
            valeur: 'LTI3 DAR 2026 — ESMT Dakar',
          ),
          const _LigneInfo(
            label: 'Source des données',
            valeur: 'UICN Liste Rouge des espèces menacées '
                '(iucnredlist.org)',
          ),
          const _LigneInfo(
            label: 'Date de collecte',
            valeur: 'Juin 2026',
          ),
          const _LigneInfo(
            label: 'Parcs couverts',
            valeur: 'Parc National du Niokolo-Koba\n'
                'Réserve de la Langue de Barbarie',
          ),
          const SizedBox(height: 24),

          // ── ODD 15 ────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF012d1d), Color(0xFF1b4332)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '🌿 ODD 15 — Vie terrestre',
                  style: TextStyle(
                    fontFamily: 'Source Serif 4',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Conserver et restaurer les écosystèmes terrestres, '
                  'en accordant une attention particulière à leur '
                  'diversité biologique.',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 13,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LigneInfo extends StatelessWidget {
  final String label;
  final String valeur;

  const _LigneInfo({required this.label, required this.valeur});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF414844),
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              valeur,
              style: const TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1c1c11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}