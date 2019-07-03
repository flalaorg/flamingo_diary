import 'dart:io';
import 'package:flutter/material.dart';
import 'ui/splashRoute.dart';
import 'package:flutter/services.dart';
import 'widget/homeAppBar.dart';

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

  final _header = UserAccountsDrawerHeader(
      accountName: Text("Shen"),
      accountEmail: Text("nmsl@jb.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage("https://img5.duitang.com/uploads/item/201407/05/20140705155446_xu3kP.thumb.700_0.jpeg"),
        radius: 35.0,
      )
  );

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        searchController: _textEditingController,
      ),
      drawer: Drawer(
        child: ListView(
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
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("wow"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(_textEditingController.value);
          }
      ),
    );
  }
}
