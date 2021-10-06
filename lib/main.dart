import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novel_covid_19/cubits/global_info_cubit.dart';
import 'package:novel_covid_19/global.dart';
import 'package:novel_covid_19/theme.dart';
import 'package:novel_covid_19/views/home_master.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isDarkTheme = prefs.getBool(SharedPreferencesKeys.isDarkTheme);
  ThemeData theme;
  if (isDarkTheme != null) {
    theme = isDarkTheme ? darkTheme : lightTheme;
  } else {
    theme = lightTheme;
  }
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(theme),
      child: MyApp(),
      builder: (context, wigdet) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Novel Covid-19 Tracker',
      theme: themeNotifier.getTheme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GlobalInfoCubit>(
            create: (context) => GlobalInfoCubit()..fetchGlobalStats(),
          ),
        ],
        child: HomePageMaster(),
      ),
    );
  }
}
