import 'package:doffa/auth/auth_provider.dart';
import 'package:doffa/auth/auth_service.dart';
import 'package:doffa/models/progress.dart';
import 'package:doffa/widgets/ads_google.dart';
import 'package:doffa/widgets/my_data.dart';
import 'package:doffa/widgets/my_date_pickers.dart';
import 'package:doffa/widgets/my_logo.dart';
import 'package:doffa/widgets/my_progress.dart';
import 'package:doffa/widgets/my_ratio.dart';
import 'package:flutter/material.dart';
import 'package:doffa/models/data.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MyDoffa extends StatelessWidget {
  MyDoffa({super.key});

  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    final startData = Data(
      date: DateTime(2025, 3, 10),
      bmi: 24.5,
      kg: 75.0,
      fat: 20.0,
      lean: 60.0,
    );
    final endData = Data(
      date: DateTime(2025, 3, 20),
      bmi: 25.5,
      kg: 76.0,
      fat: 21.0,
      lean: 61.0,
    );

    final progress = Progress(
      days: 4,
      bmi: 24.5,
      kg: 75.0,
      fat: 20.0,
      lean: 60.0,
    );
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.coffee),
                      onPressed: () {
                        _logger.i('Buy me a coffee button pressed');
                      },
                    ),
                    MyLogo(),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        final authProvider = Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        );
                        AuthService().signOut(authProvider);
                        _logger.i('Logout button pressed');
                      },
                    ),
                  ],
                ),
              ),
            ),
            MyDatePickers(title: "Start Date"),
            MyDatePickers(title: "End Date"),
            // MyGraph(),
            MyData(startData: startData, endData: endData),
            MyProgress(progress: progress),
            MyRatio(),
            AdsGoogle(),
          ],
        ),
      ),
    );
  }
}
