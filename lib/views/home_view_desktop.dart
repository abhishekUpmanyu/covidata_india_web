import 'package:covidata_web/emuns/sort.dart';
import 'package:covidata_web/utils/data.dart';
import 'package:covidata_web/utils/data_containers.dart';
import 'package:covidata_web/utils/theme.dart';
import 'package:covidata_web/utils/theme_notifier.dart';
import 'package:covidata_web/views/search_view_desktop.dart';
import 'package:covidata_web/views/state_view_desktop.dart';
import 'package:covidata_web/widgets/app_bar_desktop.dart';
import 'package:covidata_web/widgets/crd_text_card.dart';
import 'package:covidata_web/widgets/pie_chart.dart';
import 'package:covidata_web/widgets/small_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeViewDesktop extends StatefulWidget {
  @override
  _HomeViewDesktopState createState() => _HomeViewDesktopState();
}

class _HomeViewDesktopState extends State<HomeViewDesktop> {
  Daily _yesterday;
  Daily _today;

  bool _darkMode;

  bool _showAll = false;

  Sort _sort = Sort.ascending;
  SortParameter _parameter = SortParameter.name;

  @override
  void initState() {
    _setYTData();
    super.initState();
  }

  List<Widget> _stateTiles() {
    List<Widget> tiles = List();
    var temp = Data.caseData.states;
    temp.sort((a, b) {
      switch (_parameter) {
        case SortParameter.name:
          return _sort == Sort.ascending
              ? a.name.compareTo(b.name)
              : b.name.compareTo(a.name);
        case SortParameter.confirmed:
          return _sort == Sort.ascending
              ? a.confirmed.compareTo(b.confirmed)
              : b.confirmed.compareTo(a.confirmed);
        case SortParameter.active:
          return _sort == Sort.ascending
              ? a.active.compareTo(b.active)
              : b.active.compareTo(a.active);
        case SortParameter.recovered:
          return _sort == Sort.ascending
              ? a.recovered.compareTo(b.recovered)
              : b.recovered.compareTo(a.recovered);
        case SortParameter.deceased:
          return _sort == Sort.ascending
              ? a.deceased.compareTo(b.deceased)
              : b.deceased.compareTo(a.deceased);
        default:
          return a.name.compareTo(b.name);
      }
    });
    temp.sublist(0, _showAll ? temp.length : 10).forEach((state) {
      tiles.add(SmallListItem(
        title: state.name,
        confirmed: state.confirmed.toString(),
        active: state.active.toString(),
        recovered: state.recovered.toString(),
        deceased: state.deceased.toString(),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                StateViewDesktop(Data.caseData.states.indexOf(state)))),
      ));
    });
    tiles.add(GestureDetector(
        onTap: () => setState(() => _showAll = !_showAll),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_showAll?'Less':'More'),
            ),
            Icon(_showAll?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down)
          ],
        )));
    return tiles;
  }

  List<charts.Series<CADRPie, String>> _seriesPieData() {
    var pieData = [
      CADRPie('Active', Data.caseData.active, Color(0xff0099cf)),
      CADRPie('Recovered', Data.caseData.recovered, Color(0xff61dd74)),
      CADRPie('Deceased', Data.caseData.deceased, Color(0xffe75f5f))
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

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
  }

  void _setYTData() {
    if (DateTime.now().day == Data.caseData.daily.last.date.day) {
      _today = Data.caseData.daily.last;
      _yesterday = Data.caseData.daily[Data.caseData.daily.length - 2];
    } else {
      _today = Daily(
          confirmed: Data.caseData.confirmed -
              Data.caseData.daily
                  .reduce((a, b) => Daily(confirmed: a.confirmed + b.confirmed))
                  .confirmed,
          recovered: Data.caseData.recovered -
              Data.caseData.daily
                  .reduce((a, b) => Daily(recovered: a.recovered + b.recovered))
                  .recovered,
          deceased: Data.caseData.deceased -
              Data.caseData.daily
                  .reduce((a, b) => Daily(deceased: a.deceased + b.deceased))
                  .deceased);
      _yesterday = Data.caseData.daily.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkMode = (themeNotifier.getTheme() == darkTheme);
    return Row(
      children: [
        AppBarDesktop(),
        Expanded(
          child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                elevation: 0.0,
                centerTitle: true,
                title: Hero(
                    tag: 'covidata',
                    child: Text('CoviData',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Theme.of(context)
                                .appBarTheme
                                .textTheme
                                .headline6
                                .color,
                            fontFamily: 'Megrim',
                            fontSize: 28.0))),
                iconTheme: Theme.of(context).appBarTheme.iconTheme,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                          _darkMode ? Icons.brightness_3 : Icons.brightness_6,
                          color: Theme.of(context).appBarTheme.iconTheme.color),
                      onPressed: () => setState(() {
                            _darkMode = !_darkMode;
                            onThemeChanged(_darkMode, themeNotifier);
                          }))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //searchbar
                    Hero(
                      tag: 'searchbar',
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Material(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          elevation: 16.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SearchViewDesktop()));
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.search),
                                ),
                                Expanded(
                                  child: Text(
                                    'Search for District or State',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(Data.caseData.confirmed.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Darker Grotesque',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 32.0),
                                    textAlign: TextAlign.center),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.keyboard_arrow_up, size: 14.0),
                                    Text(
                                        _today.confirmed < 0
                                            ? '0'
                                            : _today.confirmed.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Darker Grotesque',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                Text('Cases Confirmed',
                                    style: TextStyle(
                                        fontFamily: 'Darker Grotesque',
                                        fontSize: 16.0),
                                    textAlign: TextAlign.center),
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.height /
                                                40)),
                                Material(
                                  elevation: 8.0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.height /
                                                40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                                Data.caseData.active.toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Darker Grotesque',
                                                    color: Color(0xff0099cf),
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.keyboard_arrow_up,
                                                    size: 14.0,
                                                    color: Color(0xff0099cf)),
                                                Text(
                                                    (_today.confirmed -
                                                                _today
                                                                    .recovered -
                                                                _today
                                                                    .deceased) <
                                                            0
                                                        ? '0'
                                                        : (_today.confirmed -
                                                                _today
                                                                    .recovered -
                                                                _today.deceased)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Darker Grotesque',
                                                        color:
                                                            Color(0xff0099cf),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                    textAlign:
                                                        TextAlign.center),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text('Active',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Darker Grotesque',
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Color(0xff0099cf),
                                                      fontSize: 16.0)),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          color: Colors.blueGrey,
                                          width: 1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                                Data.caseData.recovered
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Darker Grotesque',
                                                    color: Color(0xff61dd74),
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.keyboard_arrow_up,
                                                    size: 14.0,
                                                    color: Color(0xff61dd74)),
                                                Text(
                                                    _today.recovered < 0
                                                        ? '0'
                                                        : _today.recovered
                                                            .toString()
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Darker Grotesque',
                                                        color:
                                                            Color(0xff61dd74),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                    textAlign:
                                                        TextAlign.center),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text('Recovered',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Darker Grotesque',
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Color(0xff61dd74),
                                                      fontSize: 16.0)),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          color: Colors.blueGrey,
                                          width: 1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                                Data.caseData.deceased
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Darker Grotesque',
                                                    color: Color(0xffe75f5f),
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.keyboard_arrow_up,
                                                    size: 14.0,
                                                    color: Color(0xffe75f5f)),
                                                Text(
                                                    _today.deceased < 0
                                                        ? '0'
                                                        : _today.deceased
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Darker Grotesque',
                                                        color:
                                                            Color(0xffe75f5f),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                    textAlign:
                                                        TextAlign.center),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text('Deceased',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Darker Grotesque',
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Color(0xffe75f5f),
                                                      fontSize: 16.0)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Material(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0)),
                                  elevation: 16.0,
                                  color: Theme.of(context).accentColor,
                                  child: InkWell(
                                    onTap: () => {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('View Case History',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontFamily:
                                                      'Darker Grotesque',
                                                  fontWeight: FontWeight.w600)),
                                          Icon(Icons.navigate_next,
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.height /
                                                40)),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CrdTextCard(
                                          title: 'Yesterday',
                                          confirmed: _yesterday.confirmed,
                                          recovered: _yesterday.recovered,
                                          deceased: _yesterday.deceased),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 8.0)),
                                    Expanded(child: PieChart(_seriesPieData()))
                                  ],
                                ),
                                Text('States'),
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Column(
                                    children: _stateTiles(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
