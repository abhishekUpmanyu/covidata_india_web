import 'package:covidata_web/widgets/app_bar_desktop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewDesktop extends StatelessWidget {
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppBarDesktop(),
        Expanded(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/covidata-logo.png', width: 200.0),
                      Text('Covidata', style: TextStyle(
                        fontSize: 42.0,
                        fontFamily: 'Megrim',
                        color: Theme.of(context).appBarTheme.textTheme.headline6.color
                      ))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('About',
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'CoviData India visualises COVID-19 data in India. '
                            'It provides live statistics, along with daily count of '
                            'confirmed, active, recovered and deceased patients. '
                            'CoviData covers nation level, state level and district level cases.',
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'API',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'CoviData India uses COVID19-India API for sourcing it\'s data.',
                                    textAlign: TextAlign.justify,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: () =>
                                        launch('https://api.covid19india.org'),
                                    child: Text('https://api.covid19india.org',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontFamily: 'Darker Grotesque',
                                            fontSize: 16.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100.0,
                            width: 2.0,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Disclaimer',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                      'CoviData India does not collect any personal data, nor '
                                      'does it require access to Bluetooth, and is in no way '
                                      'meant to be an alternative to Aarogya Setu launched by '
                                      'Govt. of India. Aarogya Setu provides government '
                                      'guidelines to fight the pandemic and makes it easier to '
                                      'backtrack potential COVID-19 cases. It is strongly '
                                      'recommended that you download Aarogya Setu too.',
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Developed On',
                              style: TextStyle(
                                  fontFamily: 'Darker Grotesque',
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      18.0,
                                  color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  color: Colors.blue),
                              height: 50.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                    'assets/images/flutter-logo.png',
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => launch(
                            'https://github.com/abhishekUpmanyu/covidata_india'),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Open Source',
                                style: TextStyle(
                                    fontFamily: 'Darker Grotesque',
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        18.0),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    color: Colors.black),
                                height: 50.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                      'assets/images/github-logo.png',
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
