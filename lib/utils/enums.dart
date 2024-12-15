enum Gender { male, female }
enum Race { bajau, bidayuh, chinese, iban, indian, kadazan, malay, melanau, murut }
enum MarriageStatus { single, married, divorcedOrSeparated }
enum BloodType { undetermined, groupAplus, groupAminus, groupBplus, groupBminus, groupABplus, groupABminus, groupOplus, groupOminus }
enum YesOrNo { unanswered, yes, no }

int convertBloodTypeToInt(BloodType bt) {
  if (bt == BloodType.groupAplus) {
    return 1;
  } else if (bt == BloodType.groupAminus) {
    return 2;
  } else if (bt == BloodType.groupBplus) {
    return 3;
  } else if (bt == BloodType.groupBminus) {
    return 4;
  } else if (bt == BloodType.groupABplus) {
    return 5;
  } else if (bt == BloodType.groupABminus) {
    return 6;
  } else if (bt == BloodType.groupOplus) { // bt == BloodType.groupO
    return 7;
  } else if (bt == BloodType.groupOminus) {
    return 8;
  } else { // bt == BloodType.undetermined
    return 0;
  }
}

int convertMarriageStatusToInt(MarriageStatus ms) {
  if (ms == MarriageStatus.single) {
    return 0;
  } else if (ms == MarriageStatus.married) {
    return 1;
  } else { // ms == MarriageStatus.divorcedOrSeparated
    return 2;
  }
}

int convertRaceToInt(Race r) {
  if (r == Race.bajau) {
    return 0;
  } else if (r == Race.bidayuh) {
    return 1;
  } else if (r == Race.chinese) {
    return 2;
  } else if (r == Race.iban) {
    return 3;
  } else if (r == Race.indian) {
    return 4;
  } else if (r == Race.kadazan) {
    return 5;
  } else if (r == Race.malay) {
    return 6;
  } else if (r == Race.melanau) {
    return 7;
  } else { // r == Race.murut
    return 8;
  }
}

int convertGenderToInt(Gender g) {
  if (g == Gender.male) {
    return 0;
  } else { // g == Gender.female
    return 1;
  }
}

int convertYesOrNoToInt(YesOrNo v) {
  if (v == YesOrNo.unanswered) {
    return 0;
  } else if (v == YesOrNo.yes) {
    return 1;
  } else { // v == YesOrNo.no
    return 2;
  }
}

String formatGender(Gender g) {
  if (g == Gender.male) {
    return "Male";
  } else {
    return "Female";
  }
}

String formatRace(Race r) {
  if (r == Race.malay) {
    return "Malay";
  } else if (r == Race.chinese) {
    return "Chinese";
  } else if (r == Race.indian) {
    return "Indian";
  } else if (r == Race.iban) {
    return "Iban";
  } else if (r == Race.kadazan) {
    return "Kadazan";
  } else if (r == Race.melanau) {
    return "Melanau";
  } else if (r == Race.murut) {
    return "Murut";
  } else if (r == Race.bidayuh) {
    return "Bidayuh";
  } else {
    return "Bajau";
  }
}

String formatMarriageStatus(MarriageStatus group) {
  if (group == MarriageStatus.single) {
    return "Single";
  } else if (group == MarriageStatus.married) {
    return "Married";
  } else { // group == MarriageStatus.divorcedOrSeparated
    return "Divorced or Separated";
  }
}

String formatBloodType(BloodType group) {
  if (group == BloodType.groupAplus) {
    return "Group A+";
  } else if (group == BloodType.groupAminus) {
    return "Group A-";
  } else if (group == BloodType.groupBplus) {
    return "Group B+";
  } else if (group == BloodType.groupBminus) {
    return "Group B-";
  } else if (group == BloodType.groupABplus) {
    return "Group AB+";
  } else if (group == BloodType.groupABminus) {
    return "Group AB-";
  } else if (group == BloodType.groupOplus) {
    return "Group O+";
  } else if (group == BloodType.groupOminus) {
    return "Group O-";
  } else {
    return "Undetermined";
  }
}

String formatBloodTypeWithoutRhesus(BloodType group) {
  if (group == BloodType.groupAplus) {
    return "Group A";
  } else if (group == BloodType.groupAminus) {
    return "Group A";
  } else if (group == BloodType.groupBplus) {
    return "Group B";
  } else if (group == BloodType.groupBminus) {
    return "Group B";
  } else if (group == BloodType.groupABplus) {
    return "Group AB";
  } else if (group == BloodType.groupABminus) {
    return "Group AB";
  } else if (group == BloodType.groupOplus) {
    return "Group O";
  } else if (group == BloodType.groupOminus) {
    return "Group O";
  } else {
    return "Undetermined";
  }
}

String formatYesOrNo(YesOrNo v) {
  if (v == YesOrNo.unanswered) {
    return "Unanswered";
  } else if (v == YesOrNo.yes) {
    return "Yes";
  } else { // v == YesOrNo.no
    return "No";
  }
}