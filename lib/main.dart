import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:novel_covid_19/data/covid/covid_rest_api_respository.dart';
import 'package:novel_covid_19/data/local/insecure_data_storage.dart';
import 'package:novel_covid_19/domain/stores/local_store.dart';
import 'package:novel_covid_19/domain/stores/settings_store.dart';
import 'package:novel_covid_19/domain/use_cases/get_country_list_use_case.dart';
import 'package:novel_covid_19/domain/use_cases/get_global_info_use_case.dart';
import 'package:novel_covid_19/domain/use_cases/get_theme_use_case.dart';
import 'package:novel_covid_19/domain/use_cases/set_selected_country_use_case.dart';
import 'package:novel_covid_19/domain/use_cases/update_theme_use_case.dart';
import 'package:novel_covid_19/global.dart';
import 'package:novel_covid_19/navigation/app_navigator.dart';
import 'package:novel_covid_19/data/http/http_service.dart';
import 'package:novel_covid_19/domain/repositories/covid_repository.dart';
import 'package:novel_covid_19/theme.dart';
import 'package:novel_covid_19/ui/country_details/country_details_initial_params.dart';
import 'package:novel_covid_19/ui/country_details/country_details_navigator.dart';
import 'package:novel_covid_19/ui/country_details/country_details_page.dart';
import 'package:novel_covid_19/ui/country_details/country_details_presentation_model.dart';
import 'package:novel_covid_19/ui/country_details/country_details_presenter.dart';
import 'package:novel_covid_19/ui/country_list/country_list_initial_params.dart';
import 'package:novel_covid_19/ui/country_list/country_list_navigator.dart';
import 'package:novel_covid_19/ui/country_list/country_list_page.dart';
import 'package:novel_covid_19/ui/country_list/country_list_presentation_model.dart';
import 'package:novel_covid_19/ui/country_list/country_list_presenter.dart';
import 'package:novel_covid_19/ui/global_info/global_info_initial_params.dart';
import 'package:novel_covid_19/ui/global_info/global_info_navigator.dart';
import 'package:novel_covid_19/ui/global_info/global_info_page.dart';
import 'package:novel_covid_19/ui/global_info/global_info_presentation_model.dart';
import 'package:novel_covid_19/ui/global_info/global_info_presenter.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_initial_params.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_navigator.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_page.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_presentation_model.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_presenter.dart';
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
    ..registerLazySingleton<Client>(
      Client.new,
    )
    ..registerFactory<HttpService>(
      () => HttpService(getIt()),
    )
    ..registerLazySingleton<SettingsStore>(
      SettingsStore.new,
    )
    ..registerLazySingleton<LocalStorage>(
      () => InsecureDataStorage(),
    )
    ..registerFactory<CovidRepository>(
      () => CovidRestApiRepository(getIt()),
    )
    ..registerFactory<GetCountryListUseCase>(
      () => GetCountryListUseCase(getIt()),
    )
    ..registerFactory<SetSelectedCountryUseCase>(
      () => SetSelectedCountryUseCase(getIt()),
    )
    ..registerFactory<UpdateThemeUseCase>(
      () => UpdateThemeUseCase(getIt(), getIt()),
    )
    ..registerFactory<GetGlobalInfoUseCase>(
      () => GetGlobalInfoUseCase(getIt()),
    )
    ..registerFactory<GetThemeUseCase>(
      () => GetThemeUseCase(getIt(), getIt()),
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
    )
    ..registerFactory<CountryDetailsNavigator>(
      () => CountryDetailsNavigator(getIt()),
    )
    ..registerFactoryParam<CountryDetailsPresentationModel, CountryDetailsInitialParams, dynamic>(
      (_params, _) => CountryDetailsPresentationModel(_params, getIt()),
    )
    ..registerFactoryParam<CountryDetailsPresenter, CountryDetailsInitialParams, dynamic>(
      (params, _) => CountryDetailsPresenter(
        getIt(param1: params),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactoryParam<CountryDetailsPage, CountryDetailsInitialParams, dynamic>(
      (initialParams, _) => CountryDetailsPage(
        presenter: getIt(param1: initialParams),
      ),
    )
    ..registerFactory<GlobalInfoNavigator>(
      () => GlobalInfoNavigator(getIt()),
    )
    ..registerFactoryParam<GlobalInfoPresentationModel, GlobalInfoInitialParams, dynamic>(
      (_params, _) => GlobalInfoPresentationModel(_params, getIt()),
    )
    ..registerFactoryParam<GlobalInfoPresenter, GlobalInfoInitialParams, dynamic>(
      (params, _) => GlobalInfoPresenter(
        getIt(param1: params),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactoryParam<GlobalInfoPage, GlobalInfoInitialParams, dynamic>(
      (initialParams, _) => GlobalInfoPage(
        presenter: getIt(param1: initialParams),
      ),
    )
    //////////////
    ..registerFactory<MasterHomeNavigator>(
      () => MasterHomeNavigator(getIt()),
    )
    ..registerFactoryParam<MasterHomePresentationModel, MasterHomeInitialParams, dynamic>(
      (_params, _) => MasterHomePresentationModel(_params, getIt()),
    )
    ..registerFactoryParam<MasterHomePresenter, MasterHomeInitialParams, dynamic>(
      (params, _) => MasterHomePresenter(
        getIt(param1: params),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactoryParam<MasterHomePage, MasterHomeInitialParams, dynamic>(
      (initialParams, _) => MasterHomePage(
        presenter: getIt(param1: initialParams),
      ),
    );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SettingsStore _settingsStore;

  @override
  void initState() {
    super.initState();
    _settingsStore = getIt();
  }

  @override
  Widget build(BuildContext context) {
    final masterPage = getIt<MasterHomePage>(param1: const MasterHomeInitialParams());
    return Observer(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Novel Covid-19 Tracker',
        theme: _settingsStore.isDarkTheme ? darkTheme : lightTheme,
        home: masterPage,
      );
    });
  }
}
