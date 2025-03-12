import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

class GlobalColors {
  static const Color lightGray = Color.fromRGBO(244, 243, 241, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color gray = Color.fromRGBO(125, 125, 125, 1);
  static const Color orange = Color.fromRGBO(204, 145, 24, 1);
  static const Color background = Color.fromRGBO(255, 255, 255, 1);
}

class GlobalTextStyles {
  static const TextStyle titleXL = TextStyle(
    fontSize: 23.0,
    fontWeight: FontWeight.w900,
  );
  static  TextStyle title = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle graySubtitle = TextStyle(
    fontSize: 13.0,
    color: GlobalColors.gray,
    fontWeight: FontWeight.w400,
  );
}

class NormalDevider extends StatelessWidget {
  const NormalDevider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 12);
  }
}
