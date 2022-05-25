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

    _widgets = <Widget>[
      getIt<GlobalInfoPage>(param1: const GlobalInfoInitialParams()),
      getIt<CountryListPage>(param1: const CountryListInitialParams()),
      PersonalInfoPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.appBarTitle,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            leading: IconButton(
              icon: Icon(Icons.wb_incandescent),
              color: Theme.of(context).accentColor,
              onPressed: presenter.onBulbPressed,
            ),
            actions: <Widget>[
              Switch(
                onChanged: presenter.onThemeChanged,
                activeColor: Theme.of(context).accentColor,
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
                secondChild: NavigationRail(
                  selectedIndex: model.currentIndex,
                  onDestinationSelected: presenter.onNavigationUpdated,
                  labelType: NavigationRailLabelType.selected,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.public),
                      selectedIcon: Icon(
                        Icons.public,
                        color: Theme.of(context).accentColor,
                      ),
                      label: Text(
                        'Global',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.list),
                      selectedIcon: Icon(
                        Icons.list,
                        color: Theme.of(context).accentColor,
                      ),
                      label: Text(
                        'Countries',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.info),
                      selectedIcon: Icon(
                        Icons.info,
                        color: Theme.of(context).accentColor,
                      ),
                      label: Text(
                        'About',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: _widgets.elementAt(model.currentIndex)),
            ],
          ),
        );
      }
    );
  }
}
