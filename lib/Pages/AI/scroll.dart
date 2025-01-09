import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Horizontal Scrollable Windows')),
        body: Center(
          child: Column(
            children: [
              Flexible(
                child: FractionallySizedBox(
                  widthFactor: 0.6, // Occupies 80% of the screen width
                  heightFactor: 0.5, // Occupies 30% of the screen height
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                            width: 150,
                            color: Colors.red,
                            child: Center(child: Text('Child 1'))),
                        Container(
                            width: 200,
                            color: Colors.green,
                            child: Center(child: Text('Child 2'))),
                        Container(
                            width: 100,
                            color: Colors.blue,
                            child: Center(child: Text('Child 3'))),
                        // Add more children as needed
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
