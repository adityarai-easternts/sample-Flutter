import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/DBDemo/dog.dart';
import 'package:namer_app/DBDemo/dog_db.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class SharedPreferencesProvider {
  late SharedPreferences _sharedPref;

  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  static final instance = SharedPreferencesProvider();
}

class RandomWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RandomAppState>(
          create: (context) => RandomAppState(),
        )
      ],
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class RandomAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <Dog>[];
  var isCurrentFav = false;
  SharedPreferences sharedPref = SharedPreferencesProvider.instance._sharedPref;
  DogDatabase dogDb = DogDatabase();

  void getNext() {
    current = WordPair.random();
    isCurrentFav = false;
    notifyListeners();
  }

  void toggleFavorite() async {
    Dog currentDog = Dog(name: current.asLowerCase);
    List<Dog> dogs = await dogDb.dogs();
    print(dogs);
    if (dogs.contains(currentDog)) {
      await dogDb.removeDog(currentDog);
      isCurrentFav = false;
    } else {
      await dogDb.insertDog(currentDog);
      isCurrentFav = true;
    }
  }

  void fetchDogs() async {
    favorites = await dogDb.dogs();
    notifyListeners();
  }

  void isCurrentFavorite() {
    isCurrentFav = favorites.contains(Dog(name: current.asLowerCase));
  }

  void incrementCount() {
    if (sharedPref.containsKey("count")) {
      var count = sharedPref.getInt("count") ?? 0;
      sharedPref.setInt("count", count + 1);
      debugPrint("Shared count : $count");
    } else {
      sharedPref.setInt("count", 1);
      debugPrint("shared count ${sharedPref.getInt("count")}");
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0; // Initial selection is 0 (Home)

  @override
  Widget build(BuildContext context) {
    debugPrint("Home page rebuild....");

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites")
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => {
          setState(() {
            selectedIndex = index;
          })
        },
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [GeneratorPage(), FavoritePage()],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text("What's this?"),
                    content: Text(
                        "On clicking the \"Next\" button a new random word formed by joining two words is shown"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"))
                    ],
                  )),
          label: Icon(Icons.info)),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.read<RandomAppState>();
    appState.incrementCount();
    appState.isCurrentFavorite();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Selector<RandomAppState, WordPair>(
            selector: (_, randomAppState) => randomAppState.current,
            builder: (context, value, child) {
              return BigCard(
                wordPair: value,
              );
            },
          ),
          SizedBox(height: 10),
          InteractionButton(appState: appState),
        ],
      ),
    );
  }
}

class InteractionButton extends StatefulWidget {
  const InteractionButton({
    super.key,
    required this.appState,
  });

  final RandomAppState appState;

  @override
  State<InteractionButton> createState() => _InteractionButtonState();
}

class _InteractionButtonState extends State<InteractionButton> {
  var liked = false;
  @override
  Widget build(BuildContext context) {
    debugPrint("Rebuilding buttons");
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Selector<RandomAppState, Tuple2<WordPair, bool>>(
            selector: (_, randomAppState) =>
                Tuple2(randomAppState.current, randomAppState.isCurrentFav),
            builder: (context, value, child) {
              return ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    liked = !liked;
                  });
                  widget.appState.toggleFavorite();
                },
                icon:
                    liked ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                label: Text('Like'),
              );
            }),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            widget.appState.getNext();
            liked = widget.appState.isCurrentFav;
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.wordPair,
  });

  final WordPair wordPair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          wordPair.asLowerCase,
          style: style,
          semanticsLabel:
              "${wordPair.first.toLowerCase()} ${wordPair.second.toLowerCase()}",
        ),
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("rebuilding fav page");
    var appState = context.read<RandomAppState>();
    appState.fetchDogs();
    return Selector<RandomAppState, List<Dog>>(
      selector: (_, randomAppState) => randomAppState.favorites,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return Center(
            child: Text("Opps you dont have any favorites."),
          );
        } else {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [for (var fav in value) FavoriteItem(fav: fav)],
            ),
          );
        }
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.fav,
  });

  final Dog fav;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(fav.name),
        ),
      ),
    );
  }
}
