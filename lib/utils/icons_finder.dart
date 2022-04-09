import 'package:flutter/material.dart';

import 'zelda_heart_icons_icons.dart';
import 'zelda_magic_icons_icons.dart';
import 'zelda_stamina_icons_icons.dart';

class IconsFinder {
  const IconsFinder();

  IconData getIconData(IconFamily family, IconValue value) {
    switch (family) {
      case IconFamily.zeldaHeart:
        return ZeldaHeartIcons.allIcons[value.index];
      case IconFamily.zeldaStamina:
        return ZeldaStaminaIcons.allIcons[value.index];
      case IconFamily.zeldaMagic:
        return ZeldaMagicIcons.allIcons[value.index];
    }
  }
}

enum IconFamily {
  zeldaHeart,
  zeldaStamina,
  zeldaMagic,
}

enum IconValue {
  container,
  full,
  h75,
  h50,
  h25,
}
