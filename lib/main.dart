import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerskeleton/app/app_key.dart';
import 'package:providerskeleton/core/utils/themes/app_themes.dart';
import 'package:providerskeleton/meta/view/splash.dart';
import 'package:providerskeleton/meta/view/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: App.materialKey,
            title: 'Skeleton',
            themeMode: themeProvider.themeMode,
            theme: themeProvider.light,
            darkTheme: AppThemes.dark,
            home: const Themes(),
          );
        });
  }
}
