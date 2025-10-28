import 'package:flutter/material.dart';

class AppColors extends ChangeNotifier{
   bool isNight = false;
    Color backgroundColor1 = Color(0xFF1C1B33);
    Color backgroundColor2 = Color(0xFF2E335A);
   Color get cardColor1 => isNight ? Color(0xFF362A84) : Color(0xff293ad1);
   Color get cardColor2 => isNight ? Color(0xFF5936B4) : Color(0xff4051ec);
    Color cardColor4 = Color(0xff4051ec);
    Color cardColor3 = Color(0xff293ad1);
   Color get smallCardColor2 => isNight ? Color(0xFF48319D) : Color(0xFF2639ea);
    Color smallCardColor1 = Color(0xFF2639ea);
    Color get detailsBackgroundColor1 => isNight ?  Color(0xFF45278B):Color(0xff4051ec);
    Color get detailsBackgroundColor2 => isNight ?  Color(0xFF2E335A) :Color(0xff293ad1);
    Color bottomBarColor1 = Color(0xFF262C51);
    Color bottomBarColor2 = Color(0xFF3E3F74);
    Color textColor = Colors.white;
    Color subtextColor = Color(0xFFA8A8B1);

  void isNightFunction(bool isNight1){
    isNight = isNight1;
    notifyListeners();
  }
}