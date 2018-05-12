import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: _buildTheme(),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: Colors.white,
      primarySwatch: Colors.blue,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> users = ['John Doe', 'Jane Doe', 'Janet Doe'];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: _bottomAppBar(),
      body: new SafeArea(
        child: new Column(
          children: <Widget>[_header(), _body()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bottomAppBar() {
    return Material(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      child: BottomAppBar(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Text(
            'Contacts',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24.0),
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return Expanded(
      child: Center(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(users[index]),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
