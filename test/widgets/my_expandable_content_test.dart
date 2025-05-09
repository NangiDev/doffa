import 'package:doffa/widgets/cards/common/my_expandable_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getColorForValue', () {
    test('returns white for value 0 regardless of polarity', () {
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(0, Polarity.positive),
        Colors.white,
      );
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(0, Polarity.negative),
        Colors.white,
      );
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(0, Polarity.neutral),
        Colors.white,
      );
    });

    test('returns green for positive value with positive polarity', () {
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(10, Polarity.positive),
        Colors.green,
      );
    });

    test('returns red for positive value with negative polarity', () {
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(10, Polarity.negative),
        Colors.red,
      );
    });

    test('returns green for negative value with negative polarity', () {
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(-10, Polarity.negative),
        Colors.green,
      );
    });

    test('returns red for negative value with positive polarity', () {
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(-10, Polarity.positive),
        Colors.red,
      );
    });

    test('returns white for any value with neutral polarity', () {
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(10, Polarity.neutral),
        Colors.white,
      );
      expect(
        MyExpandableTable(
          maxWidth: 100,
          columns: [],
        ).getColorForValue(-10, Polarity.neutral),
        Colors.white,
      );
    });
  });
}
