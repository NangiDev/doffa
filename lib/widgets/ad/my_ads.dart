import 'package:doffa/widgets/ad/mobile_ad_widget.dart';
import 'package:doffa/widgets/ad/web_ad_widget.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyAds extends StatelessWidget {
  const MyAds({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return MyContainer(
          maxWidth: maxWidth,
          child: kIsWeb ? WebAdWidget() : MobileAdWidget(),
        );
      },
    );
  }
}
