import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_decoration/icon_decoration.dart';

import 'presentation/ability_creator_view/ability_creator_view.dart';
import 'presentation/character_sheet_view/character_sheet_view.dart';
import 'presentation/character_sheet_view/widgets/zelda_gauge.dart';
import 'utils/zelda_heart_icons_icons.dart';
import 'utils/zelda_magic_icons_icons.dart';
import 'utils/zelda_stamina_icons_icons.dart';

void main() {
  runApp(GoddessSuite());
}

class GoddessSuite extends StatelessWidget {
  GoddessSuite({Key? key}) : super(key: key);

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(
          title: "Farore Demo",
        ),
      ),
      GoRoute(
        path: '/character-sheet',
        builder: (context, state) => const CharacterSheetView(),
      ),
      GoRoute(
        path: '/ability-creator',
        builder: (context, state) => const AbilityCreatorView(),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Farore Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int healthValue = 20;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      setState(() {
        healthValue += 1;
      });
    });
  }

  void goCharaSheet() {
    GoRouter.of(context).push('/character-sheet');
  }

  void goAbilityCreator() {
    GoRouter.of(context).push('/ability-creator');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  ZeldaHeartIcons.container,
                  color: Colors.grey,
                  size: 48,
                ),
                const Icon(
                  ZeldaHeartIcons.hFull,
                  color: Colors.red,
                  size: 48,
                ),
                const Icon(
                  ZeldaHeartIcons.h75,
                  color: Colors.red,
                  size: 48,
                ),
                const Icon(
                  ZeldaHeartIcons.h50,
                  color: Colors.red,
                  size: 48,
                ),
                const Icon(
                  ZeldaHeartIcons.h25,
                  color: Colors.red,
                  size: 48,
                ),
                Stack(
                  children: const <Widget>[
                    Icon(
                      ZeldaHeartIcons.container,
                      color: Colors.grey,
                      size: 48,
                    ),
                    Icon(
                      ZeldaHeartIcons.h50,
                      color: Colors.red,
                      size: 48,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  ZeldaStaminaIcons.container,
                  color: Colors.grey,
                  size: 48,
                ),
                const Icon(
                  ZeldaStaminaIcons.hFull,
                  color: Colors.green,
                  size: 48,
                ),
                const Icon(
                  ZeldaStaminaIcons.h75,
                  color: Colors.green,
                  size: 48,
                ),
                const Icon(
                  ZeldaStaminaIcons.h50,
                  color: Colors.green,
                  size: 48,
                ),
                const Icon(
                  ZeldaStaminaIcons.h25,
                  color: Colors.green,
                  size: 48,
                ),
                Stack(
                  children: const <Widget>[
                    Icon(
                      ZeldaStaminaIcons.container,
                      color: Colors.grey,
                      size: 48,
                    ),
                    Icon(
                      ZeldaStaminaIcons.h50,
                      color: Colors.green,
                      size: 48,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  ZeldaMagicIcons.container,
                  color: Colors.grey,
                  size: 48,
                ),
                const Icon(
                  ZeldaMagicIcons.hFull,
                  color: Colors.blue,
                  size: 48,
                ),
                const Icon(
                  ZeldaMagicIcons.h75,
                  color: Colors.blue,
                  size: 48,
                ),
                const Icon(
                  ZeldaMagicIcons.h50,
                  color: Colors.blue,
                  size: 48,
                ),
                const Icon(
                  ZeldaMagicIcons.h25,
                  color: Colors.blue,
                  size: 48,
                ),
                Stack(
                  children: const <Widget>[
                    Icon(
                      ZeldaMagicIcons.container,
                      color: Colors.grey,
                      size: 48,
                    ),
                    Icon(
                      ZeldaMagicIcons.h50,
                      color: Colors.blue,
                      size: 48,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    DecoratedIcon(
                      icon: Icon(
                        ZeldaHeartIcons.hFull,
                        color: Colors.grey.shade800,
                        size: 48,
                      ),
                      decoration: const IconDecoration(
                        border: IconBorder(
                          color: Colors.black87,
                          width: 4,
                        ),
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            offset: Offset(2, 0),
                          )
                        ],
                      ),
                    ),
                    const Icon(
                      ZeldaHeartIcons.h75,
                      color: Colors.red,
                      size: 48,
                    )
                  ],
                ),
                const DecoratedIcon(
                  icon: Icon(
                    ZeldaStaminaIcons.hFull,
                    color: Colors.green,
                    size: 48,
                  ),
                  decoration: IconDecoration(
                    border: IconBorder(
                      color: Colors.black87,
                      width: 4,
                    ),
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        offset: Offset(2, 0),
                      )
                    ],
                  ),
                ),
                const DecoratedIcon(
                  icon: Icon(
                    ZeldaMagicIcons.hFull,
                    color: Colors.blue,
                    size: 48,
                  ),
                  decoration: IconDecoration(
                    border: IconBorder(
                      color: Colors.black87,
                      width: 4,
                    ),
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        offset: Offset(2, 0),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: ZeldaGauge(
                max: 40,
                value: healthValue,
                tempValue: 0,
                boundValue: 0,
                burntValue: 0,
                mainColor: Colors.red,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const ZeldaGauge(
                max: 40,
                value: 12,
                tempValue: 8,
                boundValue: 0,
                burntValue: 0,
                mainColor: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const ZeldaGauge(
                max: 16,
                value: 16,
                tempValue: 6,
                boundValue: 0,
                burntValue: 0,
                mainColor: Colors.blue,
              ),
            ),
            ElevatedButton(
              onPressed: goCharaSheet,
              child: const Text("Character Sheet"),
            ),
            ElevatedButton(
              onPressed: goAbilityCreator,
              child: const Text("Ability Creator"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
