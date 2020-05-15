import 'package:flutter/material.dart';

class CrdTextCard extends StatelessWidget {
  final String title;
  final int confirmed;
  final int recovered;
  final int deceased;

  const CrdTextCard(
      {Key key, @required this.title, @required this.confirmed, @required this.recovered, @ required this.deceased})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      color: Theme.of(context).cardColor,
      elevation: 16.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,
                  style: TextStyle(
                      fontFamily: 'Darker Grotesque', fontSize: 22.0)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Confirmed',
                      style: TextStyle(
                          fontSize: 16.0, fontFamily: 'Darker Grotesque')),
                  Text(confirmed.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Darker Grotesque',
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Recovered',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Darker Grotesque',
                          color: Color(0xff61dd74))),
                  Text(recovered.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Darker Grotesque',
                          color: Color(0xff61dd74),
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Deceased',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Darker Grotesque',
                          color: Color(0xffe75f5f))),
                  Text(deceased.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Darker Grotesque',
                          color: Color(0xffe75f5f),
                          fontWeight: FontWeight.w600))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
