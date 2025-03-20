import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// This code causes primaryscroll controller is attached to more than one scrollposition error but it works as expected
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fixed AppBar Scroll Demo',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<PageStorageKey> _tabKeys =
      List.generate(3, (i) => PageStorageKey('tab_$i'));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // No custom controller here; let NestedScrollView manage the primary controller.
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: const Text('Collapsible AppBar Demo'),
              pinned: false, // Allow full collapse
              floating: true, // Show on upward scroll
              snap: true, // Snap animation
              expandedHeight: 200,
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                  Tab(text: 'Tab 3'),
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        // Do not wrap TabBarView with a global Scrollbar.
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTabContent(0),
            _buildTabContent(1),
            _buildTabContent(2),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    return Builder(
      builder: (context) {
        // Wrap each CustomScrollView with its own Scrollbar.
        return Scrollbar(
          child: CustomScrollView(
            key: _tabKeys[index],
            // No custom controller; use the NestedScrollView's primary controller.
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => ListTile(
                      title: Text('Item ${i + 1}'),
                      subtitle: Text('Tab ${index + 1} Content'),
                    ),
                    childCount: 100,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Creating half circles using custom painter
class RiskRatingCircle extends StatelessWidget {
  const RiskRatingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: HalfCirclePainter(),
            size: const Size(200, 200),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '3,020',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'RISK RATING',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final radius2 = size.width / 1.8;
    const strokeWidth = 10.0;

    // Right yellow half-circle
    final yellowPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start at top
      pi, // 180 degrees
      false,
      yellowPaint,
    );

    // Left orange half-circle
    final orangePaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // canvas.drawArc(
    //   Rect.fromCircle(center: center, radius: radius),
    //   pi / 2, // Start at bottom
    //   pi, // 180 degrees
    //   false,
    //   orangePaint,
    // );

    canvas.drawArc(
      Rect.fromCircle(center: const Offset(130, 100), radius: radius2),
      pi * 1.5,
      pi,
      false,
      orangePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
