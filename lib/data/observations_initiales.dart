import '../models/observation.dart';

final List<Observation> observationsInitiales = [
  Observation(
    nom: 'Lion d\'Afrique',
    type: TypeEspece.faune,
    parc: 'Parc National du Niokolo-Koba',
    date: DateTime(2025, 1, 1),
    menacee: true,
    imagePath: 'assets/images/lion.png',
  ),
  Observation(
    nom: 'Lycaon',
    type: TypeEspece.faune,
    parc: 'Parc National du Niokolo-Koba',
    date: DateTime(2025, 1, 1),
    menacee: true,
    imagePath: 'assets/images/lycaon.png',
  ),
  Observation(
    nom: 'Éléphant de Savane',
    type: TypeEspece.faune,
    parc: 'Parc National du Niokolo-Koba',
    date: DateTime(2020, 1, 1),
    menacee: true,
    imagePath: 'assets/images/elephant.png',
  ),
  Observation(
    nom: 'Chimpanzé Verus',
    type: TypeEspece.faune,
    parc: 'Parc National du Niokolo-Koba',
    date: DateTime(2016, 1, 1),
    menacee: true,
    imagePath: 'assets/images/chimpanze.png',
  ),
  Observation(
    nom: 'Rônier',
    type: TypeEspece.flore,
    parc: 'Réserve de la Langue de Barbarie',
    date: DateTime(2016, 1, 1),
    menacee: false,
    imagePath: 'assets/images/ronier.png',
  ),
  Observation(
    nom: 'Fromager',
    type: TypeEspece.flore,
    parc: 'Parc National du Niokolo-Koba',
    date: DateTime(2017, 1, 1),
    menacee: false,
    imagePath: 'assets/images/Fromager.png',
  ),
];