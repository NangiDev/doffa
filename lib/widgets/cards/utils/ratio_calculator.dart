import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class RatioCalculator extends StatefulWidget {
  const RatioCalculator({super.key});

  @override
  State<RatioCalculator> createState() => _RatioCalculatorState();
}

class _RatioCalculatorState extends State<RatioCalculator> {
  String leanInKg = "0.0";
  String fatInKg = "0.0";

  final MetricsProvider testProvider = MetricsProvider();
  late final TextEditingController leanController;
  late final TextEditingController fatController;

  int? result;

  @override
  void initState() {
    super.initState();
    leanController = TextEditingController(text: leanInKg);
    fatController = TextEditingController(text: fatInKg);

    testProvider.setStartMetrics(
      testProvider.startMetrics.copyWith(leanInKg: 0.0, fatInKg: 0.0),
    );
  }

  @override
  void dispose() {
    leanController.dispose();
    fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = MyMontserrat.defaultStyle().copyWith(
      fontSize: 12,
      color: Colors.white70,
      height: 1.2,
      fontWeight: FontWeight.w400,
    );

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF373737),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyMontserrat(
            text: "Try it out yourself!",
            maxWidth: 14,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: leanController,
                  decoration: _inputDecoration("ΔLean (kg)", textStyle),
                  style: textStyle,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: fatController,
                  decoration: _inputDecoration("ΔFat (kg)", textStyle),
                  style: textStyle,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              final lean = double.tryParse(leanController.text) ?? 0.0;
              final fat = double.tryParse(fatController.text) ?? 0.0;

              final newEnd = testProvider.startMetrics.copyWith(
                leanInKg: lean,
                fatInKg: fat,
              );

              testProvider.setEndMetricsSync(newEnd); // <-- WAIT for this

              setState(() {
                result =
                    testProvider
                        .getRatio(); // <-- this now uses up-to-date changeMetrics
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: const MyMontserrat(
                text: 'Calculate',
                maxWidth: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (result != null)
            Center(
              child: MyMontserrat(
                text: '$result',
                maxWidth: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, TextStyle labelStyle) {
    return InputDecoration(
      labelText: label,
      labelStyle: labelStyle,
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}
