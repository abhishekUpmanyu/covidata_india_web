import 'package:covidata_web/utils/data_containers.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChart extends StatelessWidget {
  final List<charts.Series<CADRPie, String>> _seriesPieData;

  PieChart(this._seriesPieData);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: charts.PieChart(
              _seriesPieData,
              animate: true,
              animationDuration: Duration(milliseconds: 300),
              defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 50,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.auto,
                    )
                  ]),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.lens, color: Color(0xff0099cf), size: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                          tag: 'activetext',
                          child: Text('Active',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1)),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.lens, color: Color(0xff61dd74), size: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                          tag: 'recoveredtext',
                          child: Text('Recovered',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1)),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.lens, color: Color(0xffe75f5f), size: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                          tag: 'deceasedtext',
                          child: Text('Deceased',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
