import 'package:flutter/material.dart';

class FlexExamplePage extends StatelessWidget {
  const FlexExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              flex: 2, // First row takes up 2 parts of the available space
              child: Container(
                color: Colors.grey.shade300, // Color to indicate the row
                child: Row(
                  children: [
                    Flexible(
                      flex: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 2
                          : 1, // First column takes up 2 part of the available space when landscape and 1 parts of the available space when portrait
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.red,
                        child: const Center(
                          child: Text('Red Column'),
                        ),
                      ),
                    ),
                    const Spacer(), // Spacer to create space between columns as equal as the smallest of the flexible widgets
                    Flexible(
                      flex: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 1
                          : 2, // Second column takes up 1 part of the available space when landscape and 2 parts of the available space when portrait
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.green,
                        child: const Center(
                          child: Text('Green Column'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(), // Spacer to create space between rows
            Expanded(
              flex: 1, // Second row takes up 1 part of the available space
              child: Container(
                color: Colors.grey.shade300, // Color to indicate the row
                child: Row(
                  children: [
                    Flexible(
                      flex:
                          2, // First column takes up 2 part of the available space
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.blue,
                        child: const Center(
                          child: Text('Blue Column'),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 6,
                    ), // Spacer takes 6 parts of the available space
                    Flexible(
                      flex:
                          2, // Second column takes up 2 part of the available space
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.yellow,
                        child: const Center(
                          child: Text('Yellow Column'),
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
    );
  }
}
