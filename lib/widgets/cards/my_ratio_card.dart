import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyRatioCard extends StatelessWidget {
  const MyRatioCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return MyContainer(
          maxWidth: maxWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Column(
                spacing: 8,
                children: [
                  MyMontserrat(
                    text: "RATIO",
                    maxWidth: maxWidth,
                    sizeFactor: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  MyMontserrat(
                    text: "RATIO",
                    maxWidth: maxWidth,
                    sizeFactor: 32,
                    fontWeight: FontWeight.w100,
                  ),
                  Container(
                    width: maxWidth,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 55, 55, 55),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 8,
                        children: [
                          MyMontserrat(
                            text: "100",
                            maxWidth: maxWidth,
                            sizeFactor: 6,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 109, 255, 129),
                          ),
                          MyContainer(
                            maxWidth: maxWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  MyMontserrat(
                                    text: "EXCELLENT",
                                    maxWidth: maxWidth,
                                    sizeFactor: 32,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
