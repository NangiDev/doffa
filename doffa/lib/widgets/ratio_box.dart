import 'package:flutter/material.dart';

class RatioBox extends StatelessWidget {
  const RatioBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Ratio',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Tooltip(
                message: 'This is the ratio of X to Y',
                child: Icon(Icons.info_outline, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('47/53',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
