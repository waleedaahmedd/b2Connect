
import 'dart:ui';

class HexColor extends Color {

  static int _getColorFromHex(String hexColor) {
    String color = hexColor.replaceAll('#', '0xff');
    return int.parse(color);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

}


