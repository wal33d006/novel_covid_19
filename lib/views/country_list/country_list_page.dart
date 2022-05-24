import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:novel_covid_19/custom_widgets/virus_loader.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/views/country_list/country_list_presentation_model.dart';
import 'package:novel_covid_19/views/country_list/country_list_presenter.dart';

class CountryListPage extends StatefulWidget {
  const CountryListPage({required this.presenter});

  final CountryListPresenter presenter;
  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {

  CountryListPresenter get presenter => widget.presenter;

  CountryListViewModel get model => presenter.viewModel;

  var items = <CountryDetail>[];
  var _focusNode = FocusNode();
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    presenter.init();
  }

  void filterSearchResults(String query) {
    List<CountryDetail> dummySearchList = <CountryDetail>[];
    dummySearchList.addAll(model.countries);
    if (query.isNotEmpty) {
      List<CountryDetail> dummyListData = <CountryDetail>[];
      dummySearchList.forEach((item) {
        if (item.country.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(model.countries);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          return model.isLoading
              ? VirusLoader()
              : Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: TextFormField(
                    focusNode: _focusNode,
                    controller: _controller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).accentColor,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        labelText: 'Search',
                        labelStyle: TextStyle(
                            color: Theme.of(context).accentColor),
                        hintText: 'Enter country name'),
                    onChanged: filterSearchResults,
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: model.countries.length,
                  itemBuilder: (context, index) {
                    var country = model.countries[index];
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 4.0,
                        child: ListTile(
                          onTap: () {
                            _controller.clear();
                            filterSearchResults('');
                            _focusNode.unfocus();
                            presenter.onItemTapped(country);
                          },
                          title: Row(
                            children: <Widget>[
                              Text(country.country),
                            ],
                          ),
                          subtitle:
                          Text('Cases: ' + country.cases.toString()),
                          trailing: Icon(Icons.arrow_right),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  Center buildErrorMessage() {
    return Center(
      child: Text(
        'Unable to fetch data',
        style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.grey),
      ),
    );
  }

  // void _fetchCountries() async {
  //   try {
  //     setState(() => _isLoading = true);
  //     var list = await mySharedPreferences.fetchHomeCountry();
  //     var countries = await api.getAllCountriesInfo();
  //     setState(() {
  //       _countries = countries;
  //       items.addAll(_countries!);
  //       if (list != null)
  //         setState(() {
  //           _homeCountry = HomeCountry(
  //             name: list[0],
  //             cases: list[1],
  //             deaths: list[2],
  //           );
  //         });
  //     });
  //   } catch (ex) {
  //     setState(() => _countries = null);
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }
}
