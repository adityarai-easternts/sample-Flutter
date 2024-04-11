import 'package:flutter/material.dart';

class AutocompleteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autocomplete Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const AutocompleteDemo()],
        ),
      ),
    );
  }
}

@immutable
class User {
  const User({required this.email, required this.name});

  final String email;
  final String name;

  @override
  String toString() {
    return "$name, $email";
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.name == name && other.email == email;
  }

  @override
  int get hashCode => Object.hash(name, email);
}

class AutocompleteDemo extends StatelessWidget {
  const AutocompleteDemo({super.key});

  static const List<User> _userOptions = <User>[
    User(name: 'Alice', email: 'alice@example.com'),
    User(name: 'Bob', email: 'bob@example.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
  ];

  static String _displayStringForOption(User option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Autocomplete<User>(
            displayStringForOption: _displayStringForOption,
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<User>.empty();
              }
              return _userOptions.where((User option) {
                return option
                    .toString()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (User selection) {
              debugPrint("You selected ${_displayStringForOption(selection)}");
            }),
        TextFormField(
          validator: (value) {
           return "value"; 
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Entry you username"),
        )
      ],
    );
  }
}
