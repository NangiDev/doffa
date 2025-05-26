// | Expected Score | Notes                       | ΔWeight (kg) | ΔFat (kg) | ΔLean (kg) |
// | -------------- | --------------------------- | ------------ | --------- | ---------- |
// | +100           | Pure lean gain              | +10          | 0         | +10        |
// | +100           | Pure fat loss               | -10          | -10       | 0          |
// | -100           | Pure fat gain               | +10          | +10       | 0          |
// | -100           | Pure lean loss              | -10          | 0         | -10        |

// | 0              | Equal fat & lean gain       | +10          | +5        | +5         |
// | 0              | Equal fat & lean loss       | -10          | -5        | -5         |
// | 0              | No change                   | 0            | 0         | 0          |

// | +50            | Mostly lean gain            | +4           | +1        | +3         |
// | +50            | Mostly fat loss             | -4           | -3        | -1         |
// | -50            | Mostly lean loss            | -4           | -1        | -3         |
// | -50            | Mostly fat gain             | +4           | +3        | +1         |

// | +67            | Great recomposition on bulk | +4           | +1        | +5         |
// | -67            | Bad recomposition on bulk   | +4           | +5        | +1         |
// | +67            | Great recomposition on cut  | -4           | -5        | -1         |
// | -67            | Bad recomposition on cut    | -4           | -1        | -5         |

// | +33            | Decent bulk                 | +6           | +2        | +4         |
// | +33            | Decent cut                  | -6           | -4        | -2         |
// | -33            | Bad bulk                    | +6           | +4        | +2         |
// | -33            | Bad cut                     | -6           | -2        | -4         |

// Test Data for Parameterization
import 'package:doffa/calculator/simple_calculator.dart';
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
  // Pure lean gain
  TestCase(
    description: 'Pure lean gain = 100',
    fatInKg: 0,
    leanInKg: 10,
    expectedScore: 100,
  ),
  // Pure fat loss
  TestCase(
    description: 'Pure fat loss = 100',
    fatInKg: -10,
    leanInKg: 0,
    expectedScore: 100,
  ),
  // Pure fat gain
  TestCase(
    description: 'Pure fat gain = -100',
    fatInKg: 10,
    leanInKg: 0,
    expectedScore: -100,
  ),
  // Pure lean loss
  TestCase(
    description: 'Pure lean loss = -100',
    fatInKg: 0,
    leanInKg: -10,
    expectedScore: -100,
  ),
  // Equal fat & lean gain
  TestCase(
    description: 'Equal fat & lean gain = 0',
    fatInKg: 5,
    leanInKg: 5,
    expectedScore: 0,
  ),
  // Equal fat & lean loss
  TestCase(
    description: 'Equal fat & lean loss = 0',
    fatInKg: -5,
    leanInKg: -5,
    expectedScore: 0,
  ),
  // No change
  TestCase(
    description: 'No change = 0',
    fatInKg: 0,
    leanInKg: 0,
    expectedScore: 0,
  ),
  // Mostly lean gain
  TestCase(
    description: 'Mostly lean gain = 50',
    fatInKg: 1,
    leanInKg: 3,
    expectedScore: 50,
  ),
  // Mostly fat loss
  TestCase(
    description: 'Mostly fat loss = 50',
    fatInKg: -3,
    leanInKg: -1,
    expectedScore: 50,
  ),
  // Mostly lean loss
  TestCase(
    description: 'Mostly lean loss = -50',
    fatInKg: -1,
    leanInKg: -3,
    expectedScore: -50,
  ),
  // Mostly fat gain
  TestCase(
    description: 'Mostly fat gain = -50',
    fatInKg: 3,
    leanInKg: 1,
    expectedScore: -50,
  ),
  // Great recomposition on bulk
  TestCase(
    description: 'Great recomposition on bulk = 67',
    fatInKg: 1,
    leanInKg: 5,
    expectedScore: 67,
  ),
  // Bad recomposition on bulk
  TestCase(
    description: 'Bad recomposition on bulk = -67',
    fatInKg: 5,
    leanInKg: 1,
    expectedScore: -67,
  ),
  // Great recomposition on cut
  TestCase(
    description: 'Great recomposition on cut = 67',
    fatInKg: -5,
    leanInKg: -1,
    expectedScore: 67,
  ),
  // Bad recomposition on cut
  TestCase(
    description: 'Bad recomposition on cut = -67',
    fatInKg: -1,
    leanInKg: -5,
    expectedScore: -67,
  ),
  // Decent bulk
  TestCase(
    description: 'Decent bulk = 33',
    fatInKg: 2,
    leanInKg: 4,
    expectedScore: 33,
  ),
  // Decent cut
  TestCase(
    description: 'Decent cut = 33',
    fatInKg: -4,
    leanInKg: -2,
    expectedScore: 33,
  ),
  // Bad bulk
  TestCase(
    description: 'Bad bulk = -33',
    fatInKg: 4,
    leanInKg: 2,
    expectedScore: -33,
  ),
  // Bad cut
  TestCase(
    description: 'Bad cut = -33',
    fatInKg: -2,
    leanInKg: -4,
    expectedScore: -33,
  ),
  // Near 100, should clamp to 100
  TestCase(
    description: 'Near 100 boundary (clamped)',
    fatInKg: 0,
    leanInKg: 10,
    expectedScore: 100, // Should be clamped at 100
  ),
  // Near -100, should clamp to -100
  TestCase(
    description: 'Near -100 boundary (clamped)',
    fatInKg: 10,
    leanInKg: 0,
    expectedScore: -100, // Should be clamped at -100
  ),
  // Mixed case with fat and lean change but not pure
  TestCase(
    description: 'Mixed fat and lean gain (not purely lean or fat)',
    fatInKg: 3,
    leanInKg: 7,
    expectedScore: 40, // Example value, depends on your logic
  ),
];

void main() {
  final SimpleCalculator calculator = SimpleCalculator();

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  // Run parameterized tests
  for (var testCase in testCases) {
    test(testCase.description, () async {
      Metrics change = Metrics.defaultMetrics().copyWith(
        fatInKg: testCase.fatInKg,
        leanInKg: testCase.leanInKg,
      );

      expect(calculator.getRatio(change), testCase.expectedScore);
    });
  }
}
