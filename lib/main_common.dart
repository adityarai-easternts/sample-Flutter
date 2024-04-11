import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/DBDemo/dog_db.dart';
import 'package:namer_app/app_bar_demo.dart';
import 'package:namer_app/app_config.dart';
import 'package:namer_app/autocomplete_demo.dart';
import 'package:namer_app/bottom_app_bar_demo.dart';
import 'package:namer_app/bottom_nav_bar_demo.dart';
import 'package:namer_app/http_demo.dart';
import 'package:namer_app/layouts.dart';
import 'package:namer_app/list_demo.dart';
import 'package:namer_app/navigation_demo.dart';
import 'package:namer_app/random_words.dart';
import 'package:namer_app/timer/view/timer_page.dart';

part 'router.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesProvider.instance.init();
  await DogDatabase.instance.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppConfig.primaryColor)),
      routerConfig: _router,
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.appName),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RandomWords())),
                  child: Text("Random Words")),
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Layouts())),
                  child: Text("Layout Demo")),
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListDemo())),
                  child: Text("List Demo")),
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AppBarApp())),
                  child: Text("App bar Demo")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AutocompleteApp())),
                  child: Text("Autocomplete Demo")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomAppBarApp())),
                  child: Text("Bottom App Bar Demo")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavBarApp())),
                  child: Text("Bottom Nav Bar Demo")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationDemoApp())),
                  child: Text("Nav Demo using navigator")),
              ElevatedButton(
                  onPressed: () => GoRouter.of(context).push("/todo"),
                  child: Text("Nav Demo using route")),
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TimerPage())),
                  child: Text("Bloc Demo")),
              ElevatedButton(
                  onPressed: () => context.push('/http-demo'),
                  child: Text("Http Demo")),
            ],
          ),
        ),
      ),
    );
  }
}
