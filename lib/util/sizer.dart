// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class Sizer extends StatelessWidget {
  final double multiplier;
  final bool isVertical;

  const Sizer({this.multiplier = 1, this.isVertical = true})
      : assert(multiplier != null && isVertical != null);

  factory Sizer.qtr() => _qtr;
  static const _qtr = Sizer(multiplier: 0.25);

  factory Sizer.half() => _half;
  static const _half = Sizer(multiplier: 0.5);

  factory Sizer.vertical10() => _vertical10;
  static const _vertical10 = Sizer(multiplier: 0.6);

  factory Sizer.vertical20() => _vertical20;
  static const _vertical20 = Sizer(multiplier: 1.25);

  factory Sizer.vertical24() => _vertical24;
  static const _vertical24 = Sizer(multiplier: 1.5);

  factory Sizer.vertical32() => _vertical32;
  static const _vertical32 = Sizer(multiplier: 2);

  factory Sizer.vertical48() => _vertical48;
  static const _vertical48 = Sizer(multiplier: 3);

  factory Sizer.vertical64() => _vertical64;
  static const _vertical64 = Sizer(multiplier: 4);

  factory Sizer.vertical80() => _vertical80;
  static const _vertical80 = Sizer(multiplier: 5);

  factory Sizer.vertical96() => _vertical96;
  static const _vertical96 = Sizer(multiplier: 6);

  factory Sizer.vertical112() => _vertical112;
  static const _vertical112 = Sizer(multiplier: 7);

  factory Sizer.vertical120() => _vertical120;
  static const _vertical120 = Sizer(multiplier: 10);

  factory Sizer.vertical182() => _vertical182;
  static const _vertical182 = Sizer(multiplier: 12);

  factory Sizer.vertical224() => _vertical224;
  static const _vertical224 = Sizer(multiplier: 14);

  factory Sizer.qtrHorizontal() => _qtrHor;
  static const _qtrHor = Sizer(multiplier: 0.25, isVertical: false);

  factory Sizer.halfHorizontal() => _halfHorizontal;
  static const _halfHorizontal = Sizer(multiplier: 0.5, isVertical: false);

  factory Sizer.horizontal() => _horizontal;
  static const _horizontal = Sizer(isVertical: false);

  factory Sizer.horizontal24() => _horizontal24;
  static const _horizontal24 = Sizer(multiplier: 1.5, isVertical: false);

  factory Sizer.horizontal32() => _horizontal32;
  static const _horizontal32 = Sizer(multiplier: 2, isVertical: false);

  factory Sizer.horizontal48() => _horizontal48;
  static const _horizontal48 = Sizer(multiplier: 3, isVertical: false);

  factory Sizer.horizontal64() => _horizontal64;
  static const _horizontal64 = Sizer(multiplier: 4, isVertical: false);

  factory Sizer.horizontal80() => _horizontal80;
  static const _horizontal80 = Sizer(multiplier: 5, isVertical: false);

    factory Sizer.horizontal96() => _horizontal96;
  static const _horizontal96 = Sizer(multiplier: 6, isVertical: false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isVertical ? 16 * multiplier : 0,
      width: isVertical ? 0 : multiplier * 16,
    );
  }

  static vertical42() {}
}
