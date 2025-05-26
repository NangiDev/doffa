import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'my_date_pickers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doffa - Fitness Tracker',
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF3272D6), // Darker blue
        ),
      ),
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8EB8F9), // Light blue
              Color(0xFF3272D6), // Darker blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 0,
                color: Colors.transparent, // Make Card background transparent
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(child: MyDoffa()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDoffa extends StatelessWidget {
  const MyDoffa({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400, maxWidth: 600),
        child: Flex(
          direction: Axis.vertical,
          children: [
            MyLogo(),
            MyDatePickers(title: "Start Date"),
            MyDatePickers(title: "End Date"),
            MyGraph(),
            MyData(),
            MyProgress(),
            MyRatio(),
            // GoogleAds(),
          ],
        ),
      ),
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
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          direction: Axis.vertical,
          children: [
            Text(
              '80/20',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});
  @override
  Widget build(BuildContext context) {
    return ExpandableSection(
      title: "Progress",
      child: Flex(
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
      ),
    );
  }
}

class MyData extends StatelessWidget {
  const MyData({super.key});
  @override
  Widget build(BuildContext context) {
    return ExpandableSection(
      title: "Data",
      child: Flex(
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
      ),
    );
  }
}

class MyGraph extends StatelessWidget {
  const MyGraph({super.key});
  @override
  Widget build(BuildContext context) {
    return ExpandableSection(
      title: "Graph",
      child: Flex(direction: Axis.horizontal, children: [
        ],
      ),
    );
  }
}

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              './assets/opt_prism_dark.svg',
              semanticsLabel: 'App Logo',
            ),
            Text(
              'DOFFA',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableSection extends StatelessWidget {
  final String title;
  final Widget child;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [Padding(padding: const EdgeInsets.all(16), child: child)],
        ),
      ),
    );
  }
}
