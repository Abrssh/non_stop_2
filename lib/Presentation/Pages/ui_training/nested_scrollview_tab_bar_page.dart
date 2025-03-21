import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
Solves the "The provided ScrollController is attached to more than one ScrollPosition." error using a Cubit to store the scroll offsets and index while also ditching the TabBarView because the error is most probably caused by the TabBarView trying to store the TabBar Contents in cache so the scroll controller becomes attached to multiple scroll positions
 */
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fixed AppBar Scroll Demo',
      theme: ThemeData(useMaterial3: true),
      home: const NestedScrollViewTabBarPage(),
    );
  }
}

// Cubit to store scroll offsets
class ValScroll {
  final int activeIndex;
  final List<double> offsets;
  ValScroll(this.activeIndex, this.offsets);

  copywith({int? activeIndex, List<double>? offsets}) {
    return ValScroll(activeIndex ?? this.activeIndex, offsets ?? this.offsets);
  }
}

class TabOffsetCubit extends Cubit<ValScroll> {
  TabOffsetCubit() : super(ValScroll(0, [0, 0, 0]));

  void setActiveIndex(int index) {
    emit(state.copywith(activeIndex: index));
  }

  void saveOffset(int updateIndex, double offset) {
    List<double> newOffsets = [];
    newOffsets.addAll(state.offsets);
    for (int i = 0; i < newOffsets.length; i++) {
      if (i == updateIndex) {
        newOffsets[i] = offset;
        break;
      }
    }
    emit(state.copywith(offsets: newOffsets));
  }

  int getActiveIndex(int index) {
    return state.activeIndex;
  }
}

class NestedScrollViewTabBarPage extends StatefulWidget {
  const NestedScrollViewTabBarPage({super.key});

  @override
  State<NestedScrollViewTabBarPage> createState() =>
      _NestedScrollViewTabBarPageState();
}

class _NestedScrollViewTabBarPageState extends State<NestedScrollViewTabBarPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TabOffsetCubit _offsetCubit = TabOffsetCubit();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _offsetCubit.setActiveIndex(_tabController.index);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _offsetCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void scrollToPosition(double position, BuildContext cxt) {
      final primaryScrollController = PrimaryScrollController.of(cxt);
      if (primaryScrollController.hasClients) {
        primaryScrollController.animateTo(position,
            duration: const Duration(
              milliseconds: 100,
            ),
            curve: Curves.bounceInOut);
      } else {
        debugPrint("Scroll p");
      }
    }

    return BlocProvider(
      create: (_) => _offsetCubit,
      child: Scaffold(
        body: NestedScrollView(
          // This is critical for floating behavior
          floatHeaderSlivers: true,
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text('Collapsible AppBar Demo'),
                  floating: true,
                  snap: true,
                  pinned: true,
                  expandedHeight: 200,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                        ),
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Tab 1'),
                      Tab(text: 'Tab 2'),
                      Tab(text: 'Tab 3'),
                    ],
                  ),
                ),
              ),
            ];
          },

          body: BlocConsumer<TabOffsetCubit, ValScroll>(
            listener: (context, state) {
              debugPrint("Offset Rm: ${state.offsets[state.activeIndex]}");

              scrollToPosition(state.offsets[state.activeIndex], context);
            },
            listenWhen: (previous, current) =>
                previous.activeIndex != current.activeIndex,
            builder: (context, state) {
              return _TabContent(index: state.activeIndex);
            },
            buildWhen: (previous, current) =>
                previous.activeIndex != current.activeIndex,
          ),
        ),
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  final int index;

  const _TabContent({required this.index});

  @override
  Widget build(BuildContext context) {
    // Get the cubit
    final offsetCubit = context.watch<TabOffsetCubit>();
    debugPrint(
        "Active Index: ${offsetCubit.getActiveIndex(0)} ${offsetCubit.state.offsets}");

    // Use Builder to get the correct context for NestedScrollView
    return Builder(
      builder: (BuildContext context) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              // debugPrint("Notification: ${notification.metrics.pixels}");
              offsetCubit.saveOffset(index, notification.metrics.pixels);
            }
            return false;
          },
          child: CustomScrollView(
            primary: offsetCubit.getActiveIndex(0) == index,
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int i) {
                      return ListTile(
                        title: Text('Item ${i + 1}'),
                        subtitle: Text('Tab ${index + 1} Content'),
                      );
                    },
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

// Keep the RiskRatingCircle and HalfCirclePainter classes as they were
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
