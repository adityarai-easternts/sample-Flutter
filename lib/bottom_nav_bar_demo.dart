import 'package:flutter/material.dart';

class BottomNavBarApp extends StatefulWidget {
  const BottomNavBarApp({super.key, this.restorationId});
  final String? restorationId;
  @override
  State<BottomNavBarApp> createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<BottomNavBarApp>
    with RestorationMixin {
  int currentPage = 0;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 6, 7));

  late final RestorableRouteFuture<DateTime?> _restroableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
          onComplete: _selectDate,
          onPresent: (NavigatorState navigator, Object? arguments) {
            return navigator.restorablePush(_datePickerRoute,
                arguments: _selectedDate.value.millisecondsSinceEpoch);
          });

  @pragma("vm:entry-point")
  static Route<DateTime> _datePickerRoute(
      BuildContext context, Object? arguments) {
    return DialogRoute(
        context: context,
        builder: (BuildContext context) {
          return DatePickerDialog(
            restorationId: 'date_picker_dialog',
            firstDate: DateTime(2021),
            lastDate: DateTime(2022),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            // initialDate: DateTime.fromMicrosecondsSinceEpoch(arguments! as int),
          );
        });
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, "selected_date");
    registerForRestoration(
        _restroableDatePickerRouteFuture, "date_picker_route_future");
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPage,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              selectedIcon: Icon(Icons.home)),
          NavigationDestination(
              icon: Icon(Icons.notifications_sharp), label: "Notification"),
          NavigationDestination(
              icon: Badge(label: Text("2"), child: Icon(Icons.messenger_sharp)),
              label: "Messages"),
        ],
      ),
      body: <Widget>[
        //Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(9.0),
          child: SizedBox.expand(
            child: Center(
              child: Column(children: [
                Text(
                  'Home page',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                OutlinedButton(
                    onPressed: () {
                      _restroableDatePickerRouteFuture.present();
                    },
                    child: const Text("Pick date"))
              ]),
            ),
          ),
        ),

        // Notifications page
        SafeArea(
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.notifications_sharp),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Notification 1"),
                            Text("This is a notification.")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.notifications_sharp),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Notification 2"),
                            Text("This is a notification.")
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        // Messages Page
        ListView.builder(
            reverse: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text('RexOlloo'),
                  ),
                );
              }
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text('Yes?'),
                ),
              );
            })
      ][currentPage],
    );
  }
}
