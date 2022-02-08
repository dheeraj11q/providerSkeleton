import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerskeleton/core/utils/themes/app_themes.dart';

class Themes extends StatefulWidget {
  const Themes({Key? key}) : super(key: key);

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Theme"),
        actions: [
          // * [change with only dark theme with system settings]

          Switch.adaptive(
              activeColor: Theme.of(context).primaryColor,
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (v) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(v);
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You can change theme here',
            ),
            const Icon(
              Icons.pedal_bike_rounded,
              size: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.yellow,
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme(AppThemes.yellow);
                  },
                  child: Text(
                    "Yellow",
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
                MaterialButton(
                  color: Colors.black,
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme(AppThemes.dark);
                  },
                  child: Text(
                    "black",
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme(AppThemes.light);
                  },
                  child: Text(
                    "blue",
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                )
              ],
            ),
            // StreamProvider<MyModel>(
            //   create: (context) => getStreamOfMyModel(),
            //   initialData: MyModel(someValue: "loading..."),
            //   child: Text(
            //     "${Provider.of<MyModel>(context, listen: false).someValue}",
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

Stream<MyModel> getStreamOfMyModel() {
  //                        <--- Stream
  return Stream<MyModel>.periodic(
      const Duration(seconds: 1), (x) => MyModel(someValue: '$x')).take(10);
}

class MyModel {
  String? someValue = 'Hello';
  MyModel({this.someValue});

  void doSomething() {
    someValue = 'Goodbye';
  }
}
