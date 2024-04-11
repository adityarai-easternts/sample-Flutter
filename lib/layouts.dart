import 'package:flutter/material.dart';

class Layouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutMainPage(),
      ),
    );
  }
}

class LayoutMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!
        .copyWith(color: Color.fromARGB(255, 0, 0, 0));
    return SafeArea(
      child: Column(children: [
        Text(
          "Flutter layout demo",
          style: style,
          maxLines: 1,
        ),
        Image.asset(
          "images/example.png",
          width: 600,
          height: 240,
          fit: BoxFit.cover,
        ),
        LocationAddress(),
        LocationsOptions(),
        TextSection(
            description:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
      ]),
    );
  }
}

class LocationAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Oeaschinen Lake Campground",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                Text("Kandersteg, Switzerland",
                    style: TextStyle(color: Color.fromARGB(255, 128, 128, 128)))
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 2,
                ),
                Text("31")
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LocationsOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SingleOption(icon: Icons.call, text: "Call"),
          SingleOption(icon: Icons.route, text: "Route"),
          SingleOption(icon: Icons.share, text: "Share"),
        ],
      ),
    );
  }
}

class SingleOption extends StatelessWidget {
  const SingleOption({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Color.fromARGB(255, 158, 102, 231)),
        SizedBox(
          height: 5,
        ),
        Text(text, style: TextStyle(color: Color.fromARGB(255, 158, 102, 231)))
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Text(description),
    );
  }
}
