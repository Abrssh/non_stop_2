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
              flex: 3, // First row takes up 2 parts of the available space
              child: Row(
                children: [
                  Flexible(
                    flex:
                        8, // First column takes up 1 part of the available space
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.red,
                      child: const Center(
                        child: Text('Red Box'),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                  // Spacer(), // Spacer to create space between columns
                  // Flexible(
                  //   flex:
                  //       2, // Second column takes up 1 part of the available space
                  //   child: Container(
                  //     height: double.infinity,
                  //     width: double.infinity,
                  //     color: Colors.green,
                  //     child: Center(
                  //       child: Text('Green Box'),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const Spacer(), // Spacer to create space between rows
            Expanded(
              flex: 1, // Second row takes up 1 part of the available space
              child: Row(
                children: [
                  Flexible(
                    flex:
                        1, // First column takes up 1 part of the available space
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.blue,
                      child: const Center(
                        child: Text('Blue Box'),
                      ),
                    ),
                  ),
                  const Spacer(), // Spacer to create space between columns
                  Flexible(
                    flex:
                        1, // Second column takes up 1 part of the available space
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.yellow,
                      child: const Center(
                        child: Text('Yellow Box'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
