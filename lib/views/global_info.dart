import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novel_covid_19/base/base_states.dart';
import 'package:novel_covid_19/cubits/global_info_cubit.dart';
import 'package:novel_covid_19/custom_widgets/statistic_card.dart';
import 'package:novel_covid_19/custom_widgets/virus_loader.dart';
import 'package:novel_covid_19/states/global_info_state.dart';
import 'package:novel_covid_19/views/country_detail.dart';

class GlobalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GlobalInfoCubit, BaseState>(
        bloc: BlocProvider.of<GlobalInfoCubit>(context),
        builder: (context, state) {
          if (state is GlobalInfoLoadingState) return VirusLoader();
          if (state is BaseErrorState) return buildErrorMessage(context);
          if (state is GlobalInfoLoadedState)
            return ListView(
              children: <Widget>[
                if (state.homeCountry != null)
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.home,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    title: Text((state.homeCountry!.name)),
                    subtitle: Text(
                      (state.homeCountry!.cases) + '--' + (state.homeCountry!.deaths),
                    ),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CountryDetailPage(
                          countryName: (state.homeCountry!.name),
                        ),
                      ),
                    ),
                  ),
                StatisticCard(
                  color: Colors.orange,
                  text: 'Total cases',
                  icon: Icons.timeline,
                  stats: state.info!.cases!,
                ),
                StatisticCard(
                  color: Colors.green,
                  text: 'Total recovered',
                  icon: Icons.whatshot,
                  stats: state.info!.recovered!,
                ),
                StatisticCard(
                  color: Colors.red,
                  text: 'Total deaths',
                  icon: Icons.airline_seat_individual_suite,
                  stats: state.info!.deaths!,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 4.0,
                    child: ListTile(
                      leading: Icon(Icons.sentiment_very_dissatisfied),
                      title: Text('Death percentage'),
                      trailing: Text(
                        state.stats!.deathPercentage!.toStringAsFixed(2) + ' %',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
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
                        state.stats!.recoveryPercentage!.toStringAsFixed(2) + ' %',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            );
          return Container();
        },
      ),
    );
  }

  Center buildErrorMessage(context) {
    return Center(
      child: Text(
        'Unable to fetch data',
        style:
            Theme.of(context).textTheme.headline6!.copyWith(color: Colors.grey),
      ),
    );
  }
}
