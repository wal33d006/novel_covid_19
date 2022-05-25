import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      child: CircleAvatar(
                        radius: 90.0,
                        backgroundImage: NetworkImage(
                            'https://pbs.twimg.com/profile_images/1322905863452008449/xzTBfTca_400x400.jpg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Waleed Arshad',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text('waleed_arshad006@hotmail.com',
                        style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
