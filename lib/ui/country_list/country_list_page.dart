import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:novel_covid_19/ui/custom_widgets/virus_loader.dart';
import 'package:novel_covid_19/domain/entities/country_detail.dart';
import 'package:novel_covid_19/ui/country_list/country_list_presentation_model.dart';
import 'package:novel_covid_19/ui/country_list/country_list_presenter.dart';
import 'package:novel_covid_19/domain/utils/amount_formatter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
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
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onPrimary),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          labelText: 'Search',
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          hintText: 'Enter country name',
                        ),
                        onChanged: presenter.onSearchChanged,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.searchItems.length,
                      itemBuilder: (context, index) {
                        var country = model.searchItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            elevation: 4.0,
                            child: ListTile(
                              onTap: () {
                                _controller.clear();
                                presenter.onSearchChanged('');
                                _focusNode.unfocus();
                                presenter.onItemTapped(country);
                              },
                              title: Row(
                                children: <Widget>[
                                  Text(
                                    country.country,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text('Cases: ' + formatNumber(country.cases.toDouble())),
                              trailing: Icon(Icons.arrow_right),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
      }),
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
}
