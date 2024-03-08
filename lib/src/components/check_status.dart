String percentageText(bool bool1, bool bool2, bool bool3, bool bool4) {
  int trueCount = 0;

  if (bool1) trueCount++;
  if (bool2) trueCount++;
  if (bool3) trueCount++;
  if (bool4) trueCount++;

  return '$trueCount/4';
}

double percentage(bool bool1, bool bool2, bool bool3, bool bool4) {
  int trueCount = 0;
  List<bool> boolList = [bool1, bool2, bool3, bool4];

  for (bool value in boolList) {
    if (value) trueCount++;
  }

  double factor = trueCount / boolList.length;

  return factor;
}
    // double percentage(bool bool1, bool bool2, bool bool3, bool4) {
    //   if (bool1 && bool2 && bool3 && bool4) {
    //     return 1.0;
    //   } else if (bool1 && bool2 && bool3) {
    //     return 0.75;
    //   } else if (bool1 || bool2 || bool3 || bool4) {
    //     return 0.50;
    //   } else if (bool1 || bool2 || bool3) {
    //     return 0.25;
    //   } else {
    //     return 0.0;
    //   }
    // }



        // String percentageText(bool bool1, bool bool2, bool bool3, bool4) {
    //   if (bool1 && bool2 && bool3 && bool4) {
    //     return '4/4';
    //   } else if (bool1 && bool2 && bool3) {
    //     return '3/4';
    //   } else if (bool1 || bool2 || bool3 || bool4) {
    //     return '2/4';
    //   } else if (bool1 || bool2 || bool3) {
    //     return '1/4';
    //   } else {
    //     return '0/4';
    //   }
    // }

