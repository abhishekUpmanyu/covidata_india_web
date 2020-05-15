import 'package:covidata_web/emuns/graph_duration.dart';
import 'package:covidata_web/utils/data.dart';
import 'package:covidata_web/utils/data_containers.dart';
import 'package:covidata_web/views/districts_view_desktop.dart';
import 'package:covidata_web/widgets/small_list_item.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StateViewDesktop extends StatefulWidget {
  final int index;

  const StateViewDesktop(this.index);

  @override
  _StateViewDesktopState createState() => _StateViewDesktopState();
}

class _StateViewDesktopState extends State<StateViewDesktop> {
  bool _animateCharts = true;

  GraphDuration _graphDuration = GraphDuration.lifetime;

  final List<String> _lineGraphTitle = [
    'Daily Data',
    'Daily Confirmed',
    'Daily Recovered',
    'Daily Deceased'
  ];

  List<DistrictData> _topDistricts;

  @override
  void initState() {
    _getTopDistricts();
    Future.delayed(Duration(milliseconds: 500), () => _animateCharts = false);
    super.initState();
  }

  void _getTopDistricts() {
    _topDistricts = Data.caseData.states[widget.index].districts;
    _topDistricts.sort((a, b) => b.confirmed.compareTo(a.confirmed));
  }

  List<charts.Series<CADRPie, String>> _seriesPieData() {
    var pieData = [
      CADRPie('Active', Data.caseData.states[widget.index].active,
          Color(0xff0099cf)),
      CADRPie('Recovered', Data.caseData.states[widget.index].recovered,
          Color(0xff61dd74)),
      CADRPie('Deceased', Data.caseData.states[widget.index].deceased,
          Color(0xffe75f5f))
    ];
    return [
      charts.Series(
          data: pieData,
          domainFn: (CADRPie cadr, _) => cadr.label,
          measureFn: (CADRPie cadr, _) => cadr.value,
          colorFn: (CADRPie cadr, _) =>
              charts.ColorUtil.fromDartColor(cadr.color),
          id: 'Cases Pie Chart',
          labelAccessorFn: (CADRPie cadr, _) => '${cadr.value}')
    ];
  }

  List<charts.Series<DateVsValue, DateTime>> _dailyConfirmedData() {
    int maxIndex = _graphDuration == GraphDuration.week
        ? 7
        : _graphDuration == GraphDuration.month
            ? 30
            : Data.caseData.states[widget.index].daily.length;
    var confirmedData = List<DateVsValue>.generate(
        maxIndex,
        (index) => DateVsValue(
            Data
                .caseData
                .states[widget.index]
                .daily[Data.caseData.states[widget.index].daily.length -
                    maxIndex +
                    index]
                .date,
            Data
                .caseData
                .states[widget.index]
                .daily[Data.caseData.states[widget.index].daily.length -
                    maxIndex +
                    index]
                .confirmed
                .toDouble()));
    return [
      charts.Series(
          id: 'ID',
          data: confirmedData,
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff0099cf)),
          domainFn: (DateVsValue dvv, _) => dvv.date,
          measureFn: (DateVsValue dvv, _) => dvv.value)
    ];
  }

  List<charts.Series<DateVsValue, DateTime>> _dailyRecoveredData() {
    int maxIndex = _graphDuration == GraphDuration.week
        ? 7
        : _graphDuration == GraphDuration.month
            ? 30
            : Data.caseData.states[widget.index].daily.length;
    var recoveredData = List<DateVsValue>.generate(
        maxIndex,
        (index) => DateVsValue(
            Data
                .caseData
                .states[widget.index]
                .daily[Data.caseData.states[widget.index].daily.length -
                    maxIndex +
                    index]
                .date,
            Data
                .caseData
                .states[widget.index]
                .daily[Data.caseData.states[widget.index].daily.length -
                    maxIndex +
                    index]
                .recovered
                .toDouble()));
    return [
      charts.Series(
          id: 'ID',
          data: recoveredData,
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff61dd74)),
          domainFn: (DateVsValue dvv, _) => dvv.date,
          measureFn: (DateVsValue dvv, _) => dvv.value)
    ];
  }

  List<charts.Series<DateVsValue, DateTime>> _dailyDeceasedData() {
    int maxIndex = _graphDuration == GraphDuration.week
        ? 7
        : _graphDuration == GraphDuration.month
            ? 30
            : Data.caseData.states[widget.index].daily.length;
    var deceasedData = List<DateVsValue>.generate(
        maxIndex,
        (index) => DateVsValue(
            Data
                .caseData
                .states[widget.index]
                .daily[Data.caseData.states[widget.index].daily.length -
                    maxIndex +
                    index]
                .date,
            Data
                .caseData
                .states[widget.index]
                .daily[Data.caseData.states[widget.index].daily.length -
                    maxIndex +
                    index]
                .deceased
                .toDouble()));
    return [
      charts.Series(
          id: 'ID',
          data: deceasedData,
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffe75f5f)),
          domainFn: (DateVsValue dvv, _) => dvv.date,
          measureFn: (DateVsValue dvv, _) => dvv.value)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(Data.caseData.states[widget.index].name,
            style:
                TextStyle(color: Theme.of(context).textTheme.headline6.color)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                    'Total Cases  (${Data.caseData.states[widget.index].confirmed} Confirmed)',
                    style: TextStyle(
                        fontFamily: 'Darker Grotesque',
                        fontSize: MediaQuery.of(context).size.width / 24,
                        fontWeight: FontWeight.w500)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: charts.PieChart(
                            _seriesPieData(),
                            animate: _animateCharts,
                            animationDuration: Duration(milliseconds: 300),
                            defaultRenderer: charts.ArcRendererConfig(
                                arcWidth:
                                    MediaQuery.of(context).size.width ~/ 6,
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
                                  Icon(Icons.lens, color: Color(0xff0099cf)),
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
                                  Icon(Icons.lens, color: Color(0xff61dd74)),
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
                                  Icon(Icons.lens, color: Color(0xffe75f5f)),
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
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('Districts'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SmallListItem(
                      title: 'Name',
                      confirmed: 'Confirmed',
                      active: 'Active',
                      recovered: 'Recovered',
                      deceased: 'Deceased'),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                          itemCount: Data
                              .caseData.states[widget.index].districts.length,
                          itemBuilder: (BuildContext context, int i) =>
                              SmallListItem(
                                  title: _topDistricts[i].name,
                                  confirmed:
                                      _topDistricts[i].confirmed.toString(),
                                  active: _topDistricts[i].active.toString(),
                                  recovered:
                                      _topDistricts[i].recovered.toString(),
                                  deceased:
                                      _topDistricts[i].deceased.toString())),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 16.0,
                      borderRadius: BorderRadius.all(Radius.circular((5.0))),
                      color: Theme.of(context).accentColor,
                      child: InkWell(
                        onTap: () => {},
                        child: Row(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      'View ${Data.caseData.states[widget.index].name} Case History',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontFamily: 'Darker Grotesque',
                                          fontWeight: FontWeight.w600)),
                                  Icon(Icons.navigate_next, color: Colors.white)
                                ],
                              ))
                        ]),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
