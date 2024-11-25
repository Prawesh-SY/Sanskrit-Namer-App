import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanskrit_names/sanskrit_names.dart';

//import 'package:english_words/src/word_pair.dart'; ->Trying to use the .asLowerCase
//import 'package:english_words/english_words.dart'; ->Trying to use the .asLowerCase
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Sanskrit Names',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(0, 255, 0, 1)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentBoy = SanskritNames.getBoyName();
  var historyBoy = <String>[];
  //While using this array make sure the string data is included in the SanskritNames.boyName[]

  var currentGirl = SanskritNames.getGirlName();
  var historyGirl = <String>[];
  //While using this array make sure the string data is included in the SanskritNames.girlName[]

  GlobalKey? historyListKey;

  void getNextBoy() {
    // historyBoy.insert(0, currentBoy);
    // var animatedListBoy = historyListKey?.currentState as AnimatedListState?;
    // animatedListBoy?.insertItem(0);
    currentBoy = SanskritNames.getBoyName();
    notifyListeners();
  }

  void getNextGirl() {
    // histroyGirl.insert(0, currentGirl);
    // var animatedListGirl = historyListKey?.currentState as AnimatedListState?;
    // animatedListGirl?.insertItem(0);
    currentGirl = SanskritNames.getGirlName();
    notifyListeners();
  }

  //Adding new properties to the app to store the "Favorite Names"
  var favoriteBoys = <String>[];
  var favoriteGirls = <String>[];

  void toggleFavoriteBoys() {
    //Checking the Name in the favorites is from the boyName mentioned in the
    //SanskritNames class
    if (SanskritNames.boyName.contains(currentBoy)) {
      if (favoriteBoys.contains(currentBoy)) {
        favoriteBoys.remove(currentBoy);
      } else {
        favoriteBoys.add(currentBoy);
      }
    }
    notifyListeners();
  }

  void toggleFavoriteGirls() {
    //Checking the Name in the favorites is from the boyName mentioned in the
    //SanskritNames class
    if (SanskritNames.girlName.contains(currentGirl)) {
      if (favoriteGirls.contains(currentGirl)) {
        favoriteGirls.remove(currentGirl);
      } else {
        favoriteGirls.add(currentGirl);
      }
    }
    notifyListeners();
  }

  void removeFavoriteBoy(String bname) {
    if (SanskritNames.boyName.contains(bname)) {
      if (favoriteBoys.contains(bname)) {
        favoriteBoys.remove(bname);
        if (!historyBoy.contains(bname)) {
          historyBoy.add(bname);
        }
      }
      notifyListeners();
    }
  } //Checked mentally

  void removeFavoriteGirl(String gname) {
    if (SanskritNames.girlName.contains(gname)) {
      if (favoriteGirls.contains(gname)) {
        favoriteGirls.remove(gname);
        if (!historyGirl.contains(gname)) {
          historyGirl.add(gname);
        }
      }
      notifyListeners();
    }
  } //Checked mentally

  void clearAllFaovriteBoys() {
    final tempList = List<String>.from(favoriteBoys);
    favoriteBoys.clear();

    for (final name in tempList) {
      if (SanskritNames.boyName.contains(name)) {
        if (!historyBoy.contains(name)) {
          historyBoy.add(name);
        }
      }
    }
    notifyListeners();
  } //Checked mentally

  void clearAllFavoriteGirls() {
    final tempList = List<String>.from(favoriteGirls);
    favoriteGirls.clear();

    for (final name in tempList) {
      if (SanskritNames.girlName.contains(name)) {
        if (!historyGirl.contains(name)) {
          historyGirl.add(name);
        }
      }
    }
    notifyListeners();
  } //Checked mentally

  void restoreBoyName(String bname) {
    if (historyBoy.contains(bname)) {
      historyBoy.remove(bname);
      if (SanskritNames.boyName.contains(bname)) {
        if (!favoriteBoys.contains(bname)) {
          favoriteBoys.add(bname);
        }
      }
    }
    notifyListeners();
  } //Checked mentally

  void restoreGirlName(String gname) {
    if (historyGirl.contains(gname)) {
      historyGirl.remove(gname);
      if (SanskritNames.girlName.contains(gname)) {
        if (!favoriteGirls.contains(gname)) {
          favoriteGirls.add(gname);
        }
      }
    }
    notifyListeners();
  } //checked mentally

  void restoreAllBoys() {
    final tempList = List<String>.from(historyBoy);

    historyBoy.clear();
    for (final name in tempList) {
      if (SanskritNames.boyName.contains(name)) {
        if (!favoriteBoys.contains(name)) {
          favoriteBoys.add(name);
        }
      }
    }
    notifyListeners();
  } //checked mentally

  void restoreAllGirls() {
    final tempList = List<String>.from(historyGirl);

    historyGirl.clear();
    for (final name in tempList) {
      if (SanskritNames.girlName.contains(name)) {
        if (!favoriteGirls.contains(name)) {
          favoriteGirls.add(name);
        }
      }
    }
    notifyListeners();
  } //Checked mentally

  void clearhistoryBoy() {
    historyBoy.clear();
    notifyListeners();
  }

  void clearhistoryGirl() {
    historyGirl.clear();
    notifyListeners();
  }
}

//...
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  bool isSafeAreaVisible = false; //State variable for visibility

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomeInterface();
        break;
      case 1:
        page = BoyPage();
        break;
      case 2:
        page = GirlPage();
        break;
      case 3:
        page = FavoriteBoysPage();
        break;
      case 4:
        page = FavoriteGirlsPage();
        break;
      case 5:
        page = RecycleBinBoys();
        break;
      case 6:
        page = RecycleBinGirls(); //RecycleBinGirls()
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Stack(
          children: [
            //Expanded area (same as before)
            Positioned.fill(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
            //SafeArea (wrapped in AnimatedPositioned for animation)
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isSafeAreaVisible ? 0 : -constraints.maxWidth * 0.25,
              top: 45,
              width: constraints.maxWidth * 0.25,
              height: constraints.maxHeight,
              child: SafeArea(
                child: SingleChildScrollView(
                  //Wrap NavigationRail in SingleChildScrollView
                  child: ConstrainedBox(
                    //Limit the height of Navigation Rail
                    constraints: BoxConstraints(
                      minHeight: constraints
                          .maxHeight, //Minimum height is the screen height
                      maxHeight: constraints
                          .maxHeight, //Maximum height is screen height
                    ),
                    child: IntrinsicHeight(
                      //Allow NavigationRail to take its intrinsic height
                      child: NavigationRail(
                        extended: constraints.maxWidth >= 565,
                        destinations: [
                          NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.boy),
                            label: Text('Boy'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.girl),
                            label: Text('Girl'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.favorite),
                            label: Text('Favorties Boy'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.favorite),
                            label: Text('Favorties Girl'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.delete),
                            label: Text('Recycle Bin Boy'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.delete),
                            label: Text('Recycle Bin Girl'),
                          ),
                        ],
                        selectedIndex: selectedIndex,
                        onDestinationSelected: (value) {
                          setState(() {
                            selectedIndex = value;
                            isSafeAreaVisible = !isSafeAreaVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Button to toggle SafeArea visibility
            Positioned(
              top: 20,
              left: 20,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSafeAreaVisible = !isSafeAreaVisible;
                  });
                },
                child: Icon(Icons.menu),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// Class to generate Home interface
class HomeInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(name: 'Sanskrit names for children'),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

//Class to generate Boy's Name Page
class BoyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var name = appState.currentBoy;

    IconData icon;
    if (appState.favoriteBoys.contains(name)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sanskrit name for boys',
            style: TextStyle(fontSize: 24),
          ),
          BigCard(name: name),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavoriteBoys();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNextBoy();
                },
                child: Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
//...

//Class to generate Girl's Name Page
class GirlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var name = appState.currentGirl;

    IconData icon;
    if (appState.favoriteGirls.contains(name)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sanskrit Name for Girls',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          BigCard(name: name),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavoriteGirls();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNextGirl();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Class to generate FavoritesPage
class FavoriteBoysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    // Padding(
    //   padding: const EdgeInsets.all(20),
    //   child: Text('Favorite Boy'),
    // );

    if (appState.favoriteBoys.isEmpty) {
      return Center(
        child: Text('No favorties yet'),
      );
    }
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //Align to space between
              children: [
                Expanded(
                  //Wrap Text with Expanded
                  child: Text(
                    'You have '
                    '${appState.favoriteBoys.length} favorite Boy names:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton.icon(
                  // Corrected line: Added onPressed
                  onPressed: () {
                    appState.clearAllFaovriteBoys();
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Clear all'),
                ),
              ],
            )),
        for (var bname in appState.favoriteBoys)
          ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.favorite,
                semanticLabel: 'Delete',
              ),
              color: theme.colorScheme.primary,
              onPressed: () {
                appState.removeFavoriteBoy(bname);
              },
            ),
            title: Text(bname),
          )
      ],
    );
  }
}

class FavoriteGirlsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    if (appState.favoriteGirls.isEmpty) {
      return Center(
        child: Text('No favorties yet'),
      );
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                //Wrap Text with Expanded
                child: Text(
                  'You have '
                  '${appState.favoriteGirls.length} favorite Girl names:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  appState.clearAllFavoriteGirls();
                },
                icon: Icon(Icons.delete),
                label: Text('Clear all'),
              ),
            ],
          ),
        ),
        for (var gname in appState.favoriteGirls)
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.favorite),
              color: theme.colorScheme.primary,
              onPressed: () {
                appState.removeFavoriteGirl(gname);
              },
            ),
            title: Text(gname),
          )
      ],
    );
  }
}
//Class to generate  RecycleBinBoys

class RecycleBinBoys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);

    if (appState.historyBoy.isEmpty) {
      return Center(
        child: Text('The bin is empty'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                'You have ${appState.historyBoy.length} names:',
                style: TextStyle(
                  fontSize: 24,
                ),
              ), //Text
              ElevatedButton.icon(
                onPressed: () {
                  appState.restoreAllBoys();
                },
                icon: Icon(Icons.restore),
                label: Text('Restore all'),
              ), //ElevatedButton.icon
              ElevatedButton.icon(
                onPressed: () {
                  appState.clearhistoryBoy();
                },
                icon: Icon(Icons.delete),
                label: Text('Clear all'),
              ),
            ],
          ),
        ),
        for (var bname in appState.historyBoy)
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.favorite_border),
              color: theme.colorScheme.primary,
              onPressed: () {
                appState.restoreBoyName(bname);
              },
            ),
            title: Text(bname),
          ), //ListTile
      ],
    );
  }
}

//Class to generate RecycleBinGirls
class RecycleBinGirls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);

    if (appState.historyGirl.isEmpty) {
      return Center(
        child: Text('The bin is empty'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                'You have ${appState.historyGirl.length} names:',
                style: TextStyle(
                  fontSize: 24,
                ),
              ), //Text
              ElevatedButton.icon(
                onPressed: () {
                  appState.restoreAllGirls();
                },
                icon: Icon(Icons.restore),
                label: Text('Restore all'),
              ), //ElevatedButton.icon
              ElevatedButton.icon(
                onPressed: () {
                  appState.clearhistoryGirl();
                },
                icon: Icon(Icons.delete),
                label: Text('Clear all'),
              ), //ElevatedButton.icon
            ], //Row's children
          ), //Row
        ),
        for (var gname in appState.historyGirl)
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.favorite_border),
              color: theme.colorScheme.primary,
              onPressed: () {
                appState.restoreGirlName(gname);
              },
            ),
            title: Text(gname),
          ), //ListTile
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Adding TextTheme to improve text size and color
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.surfaceBright);
    return Card(
      color: theme.colorScheme.primary,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        // Change this line
        child: Text(
          name,
          style: style,
        ),
      ),
    );
  }
}
