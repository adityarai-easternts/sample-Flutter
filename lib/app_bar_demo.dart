import 'package:flutter/material.dart';

List<String> titles = <String>[
  'Cloud',
  'Beach',
  'Sunny',
];

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 3;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return DefaultTabController(
        length: tabsCount,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("App Bar Sample"),
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            scrolledUnderElevation: 3.0,
            shadowColor: Theme.of(context).shadowColor,
            bottom: TabBar(tabs: [
              Tab(
                icon: const Icon(Icons.cloud_outlined),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.beach_access_sharp),
                text: titles[1],
              ),
              Tab(
                icon: const Icon(Icons.brightness_5_sharp),
                text: titles[2],
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              ListView.builder(itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text("${titles[0]} $index"),
                );
              }),
              ListView.builder(itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text("${titles[1]} $index"),
                );
              }),
              ListView.builder(itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text("${titles[2]} $index"),
                );
              })
            ],
          ),
        ));
  }
}
