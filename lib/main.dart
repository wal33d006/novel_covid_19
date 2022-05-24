import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:novel_covid_19/controllers/covid_api.dart';
import 'package:novel_covid_19/cubits/global_info_cubit.dart';
import 'package:novel_covid_19/domain/use_cases/get_country_list_use_case.dart';
import 'package:novel_covid_19/global.dart';
import 'package:novel_covid_19/navigation/app_navigator.dart';
import 'package:novel_covid_19/theme.dart';
import 'package:novel_covid_19/views/country_list/country_list_initial_params.dart';
import 'package:novel_covid_19/views/country_list/country_list_navigator.dart';
import 'package:novel_covid_19/views/country_list/country_list_page.dart';
import 'package:novel_covid_19/views/country_list/country_list_presentation_model.dart';
import 'package:novel_covid_19/views/country_list/country_list_presenter.dart';
import 'package:novel_covid_19/views/home_master.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

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
  _initDependencies();
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(theme),
      child: MyApp(),
      builder: (context, wigdet) => MyApp(),
    ),
  );
}

void _initDependencies() {
  getIt
    ..registerFactory<AppNavigator>(
      AppNavigator.new,
    )
    ..registerFactory<CovidApi>(
      () => CovidApi(),
    )
    ..registerFactory<GetCountryListUseCase>(
      () => GetCountryListUseCase(getIt()),
    )
    ..registerFactory<CountryListNavigator>(
      () => CountryListNavigator(getIt()),
    )
    ..registerFactoryParam<CountryListPresentationModel, CountryListInitialParams, dynamic>(
      (_params, _) => CountryListPresentationModel(_params),
    )
    ..registerFactoryParam<CountryListPresenter, CountryListInitialParams, dynamic>(
      (params, _) => CountryListPresenter(
        getIt(param1: params),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactoryParam<CountryListPage, CountryListInitialParams, dynamic>(
      (initialParams, _) => CountryListPage(
        presenter: getIt(param1: initialParams),
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
