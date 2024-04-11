import 'package:flutter/material.dart';

class ListDemo extends StatelessWidget {
  final items = List<ListItem>.generate(
      1000,
      (index) => index % 6 == 0
          ? HeadingItem("heading $index")
          : MessageItem("sender $index", "message $index"));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "List Demo",
        home: Scaffold(
            appBar: AppBar(title: const Text("List demo")),
            body: Scrollbar(
              trackVisibility: true,
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                        title: item.buildTitle(context),
                        subtitle: item.buildSubtitle(context));
                  }),
            )));
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildSubtitle(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

class MessageItem implements ListItem {
  final String sender;
  final String message;

  MessageItem(this.sender, this.message);

  @override
  Widget buildSubtitle(BuildContext context) {
    return Text(message);
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Text(sender);
  }
}
