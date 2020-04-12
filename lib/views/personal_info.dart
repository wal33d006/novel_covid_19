import 'package:flutter/material.dart';
import 'package:novel_covid_19/custom_widgets/theme_switch.dart';

class PersonalInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        actions: <Widget>[ThemeSwitch()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 93.0,
                      backgroundColor: Theme.of(context).accentColor,
                      child: CircleAvatar(
                        radius: 90.0,
                        backgroundImage: NetworkImage(
                            'https://media-exp1.licdn.com/dms/image/C4E03AQG7du-pU1O8kw/profile-displayphoto-shrink_200_200/0?e=1592438400&v=beta&t=GHaowcIAB7eDs5TlWiTKUqr1EXo_rBM1AsZh85AFcJg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Waleed Arshad',
                        style: Theme.of(context).textTheme.headline.copyWith(color: Theme.of(context).accentColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text('waleed_arshad006@hotmail.com',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Built with '),
                    Icon(
                      Icons.favorite,
                      color: Colors.blue,
                    ),
                    Text(' in Flutter')
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
