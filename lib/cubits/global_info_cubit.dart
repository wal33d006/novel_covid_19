import 'package:novel_covid_19/base/base_cubit.dart';
import 'package:novel_covid_19/base/base_states.dart';
import 'package:novel_covid_19/controllers/covid_api.dart';
import 'package:novel_covid_19/data/models/country_model.dart';
import 'package:novel_covid_19/data/models/global_info_model.dart';
import 'package:novel_covid_19/main.dart';
import 'package:novel_covid_19/states/global_info_state.dart';

import '../global.dart';

class GlobalInfoCubit extends BaseCubit<BaseState> {
  CovidApi api = getIt();

  fetchGlobalStats() async {
    makeACall(
        function: () async {
          emit(GlobalInfoLoadingState());

          var response = await api.getGlobalInfo();
          var deathPercentage = (response.deaths! / response.cases!) * 100;
          var recoveryPercentage =
              (response.recovered! / response.cases!) * 100;
          var model = GlobalInfoPercentageModel(
            deathPercentage: deathPercentage,
            recoveryPercentage: recoveryPercentage,
            activePercentage: 100 - (deathPercentage + recoveryPercentage),
          );

          HomeCountry? _homeCountry;
          var list = await mySharedPreferences.fetchHomeCountry();
          if (list != null) {
            _homeCountry = HomeCountry(
              name: list[0],
              cases: list[1],
              deaths: list[2],
            );
          }

          emit(GlobalInfoLoadedState(
            stats: model,
            homeCountry: _homeCountry,
            info: response,
          ));
        },
        onError: (state) => emit(state));
  }
}
