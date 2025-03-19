import 'package:flutter/material.dart';

class AdvancedScrollPage extends StatelessWidget {
  const AdvancedScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "MediaQuery.of(context).size.height: ${MediaQuery.of(context).size.width}");
    return Container(
      color: Colors.grey.shade300,
      height: 600,
      child: CustomScrollView(slivers: [
        const SliverAppBar(
          // remove the leading icon
          automaticallyImplyLeading: false,
          title: Text('Advanced Scroll'),
          // pinned: true,
          floating: true,
          centerTitle: true,
        ),
        SliverToBoxAdapter(
            child: Container(
          margin: const EdgeInsets.all(10),
          height: 200,
          color: Colors.red,
          child: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.redAccent,
                  )),
              Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.greenAccent,
                  ))
            ],
          ),
        )),
        SliverToBoxAdapter(child: Container(height: 200, color: Colors.yellow)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 40,
              itemBuilder: (context, index) => Text("Data $index"),
            ),
          ),
        ),
        SliverToBoxAdapter(child: Container(height: 200, color: Colors.red)),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 490.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 2.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('Grid Item $index'),
              );
            },
            childCount: 20,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.blue[100],
                height: 150.0,
                child: const Center(child: Text('Fixed Item 1')),
              ),
              Container(
                color: Colors.blue[200],
                height: 150.0,
                child: const Center(child: Text('Fixed Item 2')),
              ),
              Container(
                color: Colors.blue[300],
                height: 150.0,
                child: const Center(child: Text('Fixed Item 3')),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
