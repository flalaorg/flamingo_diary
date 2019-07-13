import 'dart:io';
import 'package:flutter/material.dart';
import 'ui/splashRoute.dart';
import 'package:flutter/services.dart';
import 'widget/homeAppBar.dart';
import 'widget/diaryListWidget.dart';
import 'widget/CalendarWidget.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: SplashRoute(
        homeRoute: Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  TextEditingController _textEditingController;
  bool _needHiddenCalendar = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.clear();
    _textEditingController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        searchController: _textEditingController,
        onClickCalendarIcon: () {
          setState(() {
            _needHiddenCalendar = !_needHiddenCalendar;
          });
        },
      ),
      drawer: Drawer(
        child: DrawerListWidget(),
      ),
      body: DiaryListWidget(
        needHiddenCalendar: _needHiddenCalendar,
        diaryListBuilder: createDiaryList(),
        calendarWidget: CalendarWidget(),
      ),
    );
  }
}

class DrawerListWidget extends StatelessWidget {

  final _header = UserAccountsDrawerHeader(
      accountName: Text("Shen"),
      accountEmail: Text("nmsl@jb.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage("https://img5.duitang.com/uploads/item/201407/05/20140705155446_xu3kP.thumb.700_0.jpeg"),
        radius: 35.0,
      )
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _header,
        ListTile(
          title: Text("item 1"),
          leading: CircleAvatar(child: Icon(Icons.add),),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          title: Text("item 2"),
          leading: CircleAvatar(child: Text("B2"),),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          title: Text("item 3"),
          leading: CircleAvatar(child: Text("JB"),),
          onTap: () => Navigator.pop(context),
        )
      ],
    );
  }
}


SliverChildBuilderDelegate createDiaryList() =>
    SliverChildBuilderDelegate((BuildContext context, int index) =>
        Card(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  alignment: Alignment.centerLeft,
                  child: Text("Column Top"),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  alignment: Alignment.centerLeft,
                  child: Text("Column Bottom"),
                ),
              )
            ],
          ),
        ),
        childCount: 20
    );


