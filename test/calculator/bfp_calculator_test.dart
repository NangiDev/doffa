// Test Data for Parameterization
import 'dart:math';

import 'package:doffa/calculator/bfp_calculator.dart';
import 'package:doffa/common/models.dart';
import 'package:flutter_test/flutter_test.dart';

class TestCase {
  final String description;
  final double fatInKg;
  final double leanInKg;
  final int expectedScore;

  TestCase({
    required this.description,
    required this.fatInKg,
    required this.leanInKg,
    required this.expectedScore,
  });
}

final List<TestCase> testCases = [
  TestCase(
    description: 'Pure lean gain = 100',
    fatInKg: 0,
    leanInKg: 10,
    expectedScore: 100,
  ),
  TestCase(
    description: 'Pure fat gain = -100',
    fatInKg: 10,
    leanInKg: 0,
    expectedScore: -100,
  ),
  TestCase(
    description: 'Pure lean loss = -100',
    fatInKg: 0,
    leanInKg: -10,
    expectedScore: -100,
  ),
  TestCase(
    description: 'Pure fat loss = 100',
    fatInKg: -10,
    leanInKg: 0,
    expectedScore: 100,
  ),
  TestCase(
    description: 'Equal fat & lean loss = 0',
    fatInKg: -5,
    leanInKg: -5,
    expectedScore: 0,
  ),
  TestCase(
    description: 'Equal fat & lean gain = 0',
    fatInKg: 5,
    leanInKg: 5,
    expectedScore: 0,
  ),
  TestCase(
    description: 'Gain 2kg lean, 1kg fat → positive recomposition',
    fatInKg: 1,
    leanInKg: 2,
    expectedScore: 33,
  ),
  TestCase(
    description: 'Gain 1kg lean, 2kg fat → negative recomposition',
    fatInKg: 2,
    leanInKg: 1,
    expectedScore: -33,
  ),
  TestCase(
    description: 'Lose 2kg fat, 1kg lean → mildly positive cut',
    fatInKg: -2,
    leanInKg: -1,
    expectedScore: 33,
  ),
  TestCase(
    description: 'Lose 1kg fat, 2kg lean → bad cut',
    fatInKg: -1,
    leanInKg: -2,
    expectedScore: -33,
  ),
  TestCase(
    description: 'Gain 3kg lean, 1kg fat → strong lean bulk',
    fatInKg: 1,
    leanInKg: 3,
    expectedScore: 50,
  ),
  TestCase(
    description: 'Gain 3kg fat, 1kg lean → poor bulk',
    fatInKg: 3,
    leanInKg: 1,
    expectedScore: -50,
  ),
  TestCase(
    description: 'Lose 3kg fat, 1kg lean → good fat loss',
    fatInKg: -3,
    leanInKg: -1,
    expectedScore: 50,
  ),
  TestCase(
    description: 'Lose 3kg lean, 1kg fat → poor cut',
    fatInKg: -1,
    leanInKg: -3,
    expectedScore: -50,
  ),
  TestCase(
    description: 'No change → neutral',
    fatInKg: 0,
    leanInKg: 0,
    expectedScore: 0,
  ),
  TestCase(
    description: 'Lose 1kg lean, gain 2kg fat → poor cut',
    fatInKg: 2,
    leanInKg: -1,
    expectedScore: -100,
  ),
  TestCase(
    description: 'Gain 4kg lean, 1kg fat → excellent lean bulk',
    fatInKg: 1,
    leanInKg: 4,
    expectedScore: 60,
  ),
  TestCase(
    description: 'Gain 4kg fat, 1kg lean → very poor bulk',
    fatInKg: 4,
    leanInKg: 1,
    expectedScore: -60,
  ),
  TestCase(
    description: 'Lose 4kg fat, 1kg lean → excellent fat loss',
    fatInKg: -4,
    leanInKg: -1,
    expectedScore: 60,
  ),
  TestCase(
    description: 'Lose 4kg lean, 1kg fat → very poor cut',
    fatInKg: -1,
    leanInKg: -4,
    expectedScore: -60,
  ),
  TestCase(
    description: 'Lose 2kg fat, gain 2kg lean → reverse recomposition',
    fatInKg: -2,
    leanInKg: 2,
    expectedScore: 100,
  ),
  TestCase(
    description: 'Gain 2kg fat, lose 2kg lean → reversed and terrible',
    fatInKg: 2,
    leanInKg: -2,
    expectedScore: -100,
  ),
  TestCase(
    description: 'Gain 1kg fat, lose 1kg lean → pure swap for the worse',
    fatInKg: 1,
    leanInKg: -1,
    expectedScore: -100,
  ),
  TestCase(
    description: 'Lose 1kg fat, gain 1kg lean → pure swap for the better',
    fatInKg: -1,
    leanInKg: 1,
    expectedScore: 100,
  ),
  TestCase(
    description: 'Gain 1kg fat, no lean change → bad bulk',
    fatInKg: 1,
    leanInKg: 0,
    expectedScore: -100,
  ),
  TestCase(
    description: 'Lose 1kg fat, no lean change → good cut',
    fatInKg: -1,
    leanInKg: 0,
    expectedScore: 100,
  ),
  TestCase(
    description: 'Lose 1kg lean, no fat change → bad cut',
    fatInKg: 0,
    leanInKg: -1,
    expectedScore: -100,
  ),
  TestCase(
    description: 'Gain 1kg lean, no fat change → good bulk',
    fatInKg: 0,
    leanInKg: 1,
    expectedScore: 100,
  ),
  TestCase(
    description: 'Gain 0.5kg lean, 0.5kg fat → neutral gain',
    fatInKg: 0.5,
    leanInKg: 0.5,
    expectedScore: 0,
  ),
  TestCase(
    description: 'Lose 0.5kg lean, 0.5kg fat → neutral loss',
    fatInKg: -0.5,
    leanInKg: -0.5,
    expectedScore: 0,
  ),
];

void main() {
  final BfpCalculator calculator = BfpCalculator();

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  // Run parameterized tests
  for (var testCase in testCases) {
    test(testCase.description, () async {
      Metrics start = Metrics.defaultMetrics();
      Metrics end = Metrics.defaultMetrics().copyWith(
        fatInKg: testCase.fatInKg,
        leanInKg: testCase.leanInKg,
        fatInPercentage:
            (testCase.fatInKg / max(testCase.fatInKg + testCase.leanInKg, 1)) *
            100,
        weightInKg: testCase.fatInKg + testCase.leanInKg,
      );
      Metrics change = end.difference(start);

      expect(calculator.getRatio(change), testCase.expectedScore);
    });
  }
}
