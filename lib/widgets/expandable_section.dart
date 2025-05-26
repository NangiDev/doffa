import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpandableSection extends StatefulWidget {
  final String title;
  final Widget child;
  final String storageKey; // Key used to store the expanded state

  const ExpandableSection({
    super.key,
    required this.title,
    required this.child,
    required this.storageKey, // Each section has a unique key
  });

  @override
  _ExpandableSectionState createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late Future<bool>
  _loadExpandedStateFuture; // Future to load the expanded state

  @override
  void initState() {
    super.initState();
    _loadExpandedStateFuture =
        _loadExpandedState(); // Load the expanded state when the widget is initialized
  }

  // Load the expanded state from shared preferences
  Future<bool> _loadExpandedState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(widget.storageKey) ??
        false; // Default to false (collapsed)
  }

  // Save the expanded state to shared preferences
  Future<void> _saveExpandedState(bool isExpanded) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.storageKey, isExpanded); // Save the state
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _loadExpandedStateFuture, // Use the future to load the state
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While loading, you can show a loading spinner or something else
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        bool isExpanded =
            snapshot.data ?? false; // Default to false if no state is found

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpansionTile(
              title: Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              initiallyExpanded:
                  isExpanded, // Set the expansion state from shared preferences
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isExpanded =
                      expanded; // Update the local state when expansion changes
                });
                _saveExpandedState(expanded); // Persist the new state
              },
              children: [
                Padding(padding: const EdgeInsets.all(16), child: widget.child),
              ],
            ),
          ),
        );
      },
    );
  }
}
