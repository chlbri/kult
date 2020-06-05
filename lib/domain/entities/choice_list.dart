enum ChoiceList {
  SAMEDI1,
  SAMEDI2,
  DIMANCHE1,
  DIMANCHE2,
  NONE
}

extension ChoiceListExtension on ChoiceList {
  String get text {
    String out;
    switch (this) {
      case ChoiceList.SAMEDI1:
        out = 'Samedi 8h à 10h';
        break;
      case ChoiceList.SAMEDI2:
        out = 'Samedi 11h à 13h';
        break;
      case ChoiceList.DIMANCHE1:
        out = 'Dimanche 7h30 à 9h30';
        break;
      case ChoiceList.DIMANCHE2:
        out = 'Dimanche 11h à 13h';
        break;
      case ChoiceList.NONE:
        // TODO: Handle this case.
        break;
    }
    return out;
  }

  String get msg {
    String out;
    switch (this) {
      case ChoiceList.SAMEDI1:
        out = 'qui se tiendra ce samedi, de 8h à 10h';
        break;
      case ChoiceList.SAMEDI2:
        out = 'qui se tiendra ce samedi, de 11h à 13h';
        break;
      case ChoiceList.DIMANCHE1:
        out = 'qui se tiendra ce dimanche, de 7h30 à 9h30';
        break;
      case ChoiceList.DIMANCHE2:
        out = 'qui se tiendra ce dimanche, de 11h à 13h';
        break;
      case ChoiceList.NONE:
        // TODO: Handle this case.
        break;
    }
    return out;
  }
}

final c = ChoiceList.values[0];
