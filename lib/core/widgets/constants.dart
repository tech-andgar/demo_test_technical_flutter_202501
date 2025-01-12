//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';

enum FontFamily {
  futuraBookItalic('Futura Book Italic'),
  futur('futur'),
  futuraLightBt('futura light bt'),
  futuraExtraBlack('Futura Extra Black'),
  futuraMediumCondensedBt('futura medium condensed bt'),
  futuraMediumItalic('Futura Medium Italic'),
  futuraHeavyItalic('Futura Heavy Italic'),
  futuraLightItalic('Futura Light Italic'),
  tt0205m('tt0205m '),
  futuraBold('Futura Bold'),
  futuraHeavy('Futura Heavy'),
  futuraBook('Futura Book'),
  unicodeFuturab('unicode.futurab'),
  futuraMediumBt('futura medium bt'),
  futuraLight('Futura Light'),
  futuraXblkBt('Futura XBlk BT'),
  futuraBoldItalic('Futura Bold Italic'),
  unicodeFuturabb('unicode.futurabb');

  const FontFamily(this.value);

  final String value;
}

const sizedBoxH16 = SizedBox(height: 16);
const sizedBoxH12 = SizedBox(height: 12);
