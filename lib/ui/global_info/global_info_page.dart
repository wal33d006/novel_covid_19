import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:novel_covid_19/ui/custom_widgets/statistic_card.dart';
import 'package:novel_covid_19/ui/custom_widgets/virus_loader.dart';
import 'package:novel_covid_19/domain/entities/global_info.dart';
import 'package:novel_covid_19/ui/global_info/global_info_presentation_model.dart';
import 'package:novel_covid_19/ui/global_info/global_info_presenter.dart';

class GlobalInfoPage extends StatefulWidget {
  final GlobalInfoPresenter presenter;

  const GlobalInfoPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  _GlobalInfoPageState createState() => _GlobalInfoPageState();
}

class _GlobalInfoPageState extends State<GlobalInfoPage> {
  GlobalInfoPresenter get presenter => widget.presenter;

  GlobalInfoViewModel get model => presenter.viewModel;

  GlobalInfo get info => model.globalInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter.navigator.context = context;
    presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return model.isLoading
            ? VirusLoader()
            : ListView(
                children: <Widget>[
                  StatisticCard(
                    color: Colors.orange,
                    text: 'Total cases',
                    icon: Icons.timeline,
                    stats: info.cases,
                  ),
                  StatisticCard(
                    color: Colors.green,
                    text: 'Total recovered',
                    icon: Icons.whatshot,
                    stats: info.recovered,
                  ),
                  StatisticCard(
                    color: Colors.red,
                    text: 'Total deaths',
                    icon: Icons.airline_seat_individual_suite,
                    stats: info.deaths,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 4.0,
                      child: ListTile(
                        leading: Icon(Icons.sentiment_very_dissatisfied),
                        title: Text('Death percentage'),
                        trailing: Text(
                          info.deathPercentageString + ' %',
                          style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 4.0,
                      child: ListTile(
                        leading: Icon(Icons.sentiment_very_satisfied),
                        title: Text('Recovery percentage'),
                        trailing: Text(
                          info.recoveryPercentageString + ' %',
                          style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              );
      },
    );
  }
}
