import 'package:flutter/widgets.dart';

class ZeldaHeartIcons {
  ZeldaHeartIcons._();

  static const _kFontFam = 'ZeldaHeartIcons';
  static const String? _kFontPkg = null;

  static const IconData container =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData h25 =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData h50 =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData h75 =
      IconData(0xe817, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData hFull =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  static const List<IconData> allIcons = <IconData>[
    container,
    hFull,
    h75,
    h50,
    h25,
  ];
}
