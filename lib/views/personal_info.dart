import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
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
                      backgroundColor: Theme.of(context).accentColor,
                      child: CircleAvatar(
                        radius: 90.0,
                        backgroundImage: NetworkImage(
                            'https://media-exp1.licdn.com/dms/image/C4D03AQEF0bDkllWyAQ/profile-displayphoto-shrink_400_400/0?e=1602115200&v=beta&t=FvkFAnHPiE2ipkx2Qw9OE-lo8PpW7K2Y-T4xenUN5sw'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Waleed Arshad',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(color: Theme.of(context).accentColor),
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
