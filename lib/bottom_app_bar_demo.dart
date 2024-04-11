import 'package:flutter/material.dart';

class BottomAppBarApp extends StatefulWidget {
  const BottomAppBarApp({super.key});

  @override
  State createState() => _BottomAppBarExampleState();
}

class _BottomAppBarExampleState extends State<BottomAppBarApp> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      debugPrint("selected index $_selectedIndex");
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bottom App Bar Demo"),
      ),
      body: SizedBox(
        height: 20,
        width: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  color: Colors.amber,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Modal bottom sheet"),
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close bottom sheet"))
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: IconTheme(
            data: IconThemeData(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                IconButton(
                  tooltip: 'Search',
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  tooltip: 'Favorite',
                  icon: const Icon(Icons.favorite),
                  onPressed: () {},
                ),
              ],
            ),
          )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text("Drawer header")),
            ListTile(
              title: const Text("Home"),
              onTap: () {
                _onItemTap(0);
              },
            ),
            ListTile(
              title: const Text("Settings"),
              onTap: () {
                _onItemTap(1);
              },
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () {
                _onItemTap(2);
              },
            )
          ],
        ),
      ),
    );
  }
}
