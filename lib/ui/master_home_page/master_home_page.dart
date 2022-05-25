import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:novel_covid_19/main.dart';
import 'package:novel_covid_19/ui/country_list/country_list_initial_params.dart';
import 'package:novel_covid_19/ui/country_list/country_list_page.dart';
import 'package:novel_covid_19/ui/global_info/global_info_initial_params.dart';
import 'package:novel_covid_19/ui/global_info/global_info_page.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_presentation_model.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_presenter.dart';
import 'package:novel_covid_19/ui/personal_info/personal_info_page.dart';

class MasterHomePage extends StatefulWidget {
  final MasterHomePresenter presenter;

  const MasterHomePage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  _MasterHomePageState createState() => _MasterHomePageState();
}

class _MasterHomePageState extends State<MasterHomePage> {
  MasterHomePresenter get presenter => widget.presenter;

  MasterHomeViewModel get model => presenter.viewModel;

  List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();

    presenter.navigator.context = context;

    presenter.init();

    _widgets = <Widget>[
      getIt<GlobalInfoPage>(param1: const GlobalInfoInitialParams()),
      getIt<CountryListPage>(param1: const CountryListInitialParams()),
      PersonalInfoPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            model.appBarTitle,
          ),
          leading: IconButton(
            icon: Icon(Icons.wb_incandescent),
            onPressed: presenter.onBulbPressed,
          ),
          actions: <Widget>[
            Switch(
              onChanged: presenter.onThemeChanged,
              activeColor: Theme.of(context).colorScheme.onPrimary,
              value: model.isDarkTheme,
            ),
          ],
        ),
        body: Row(
          children: [
            AnimatedCrossFade(
              crossFadeState: model.showNavigationRail ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 300),
              firstChild: Container(),
              secondChild: Container(
                color: Theme.of(context).colorScheme.background,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: NavigationRail(
                      selectedIndex: model.currentIndex,
                      onDestinationSelected: presenter.onNavigationUpdated,
                      labelType: NavigationRailLabelType.selected,
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(Icons.public, color: Theme.of(context).colorScheme.onError),
                          selectedIcon: Icon(Icons.public, color: Theme.of(context).colorScheme.onPrimary),
                          label: Text(
                            'Global',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.list, color: Theme.of(context).colorScheme.onError),
                          selectedIcon: Icon(Icons.list, color: Theme.of(context).colorScheme.onPrimary),
                          label: Text(
                            'Countries',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.info, color: Theme.of(context).colorScheme.onError),
                          selectedIcon: Icon(Icons.info, color: Theme.of(context).colorScheme.onPrimary),
                          label: Text(
                            'About',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: _widgets.elementAt(model.currentIndex)),
          ],
        ),
      );
    });
  }
}
