import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doffa - Fitness Tracker',
      theme: ThemeData.from(colorScheme: ColorScheme.light()),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(padding: EdgeInsets.all(32.0), child: MyDoffa()),
      ),
    );
  }
}

class MyDoffa extends StatelessWidget {
  const MyDoffa({super.key});
  @override
  Widget build(BuildContext context) {
    return Flex(
      spacing: 16.0,
      direction: Axis.vertical,
      children: [
        MyLogo(),
        MyDatePickers(),
        MyGraph(),
        MyData(),
        MyProgress(),
        MyRatio(),
        GoogleAds(),
      ],
    );
  }
}

class GoogleAds extends StatelessWidget {
  const GoogleAds({super.key});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyRatio extends StatelessWidget {
  const MyRatio({super.key});
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Progress',
              hintText: 'Enter Progress',
              prefixIcon: Icon(Icons.trending_up),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Goal',
              hintText: 'Enter Goal',
              prefixIcon: Icon(Icons.flag),
            ),
          ),
        ),
      ],
    );
  }
}

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Progress',
              hintText: 'Enter Progress',
              prefixIcon: Icon(Icons.trending_up),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Goal',
              hintText: 'Enter Goal',
              prefixIcon: Icon(Icons.flag),
            ),
          ),
        ),
      ],
    );
  }
}

class MyData extends StatelessWidget {
  const MyData({super.key});
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Weight',
              hintText: 'Enter Weight',
              prefixIcon: Icon(Icons.line_weight),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Height',
              hintText: 'Enter Height',
              prefixIcon: Icon(Icons.height),
            ),
          ),
        ),
      ],
    );
  }
}

class MyGraph extends StatelessWidget {
  const MyGraph({super.key});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyDatePickers extends StatelessWidget {
  const MyDatePickers({super.key});
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      spacing: 16.0,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                  },
                ),
                Text(
                  'Start Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        SvgPicture.asset(
          './assets/opt_prism_dark.svg',
          semanticsLabel: 'App Logo',
        ),
        Text(
          'DOFFA',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
