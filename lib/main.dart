import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer timer5;

  int _counter = 0;
  int qwe = 1;
  String ewq = "qwe";
  _incrementCounterplus() {
    setState(() {
      if (qwe == 2) {
        _counter++;
      }
      _counter++;
      listqwe.add('Нажали +');
    });
    timer5.cancel();
    timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
  }

  _clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('count');
    prefs.remove('list');
    setState(() {
      _counter = 0;
      listqwe = [];
      timer5.cancel();
      timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
    });
  }

  _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('count', _counter);
    prefs.setStringList('list', listqwe);
    timer5.cancel();
    timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
  }

  _incrementCounterminus() {
    setState(() {
      if (qwe == 2) {
        _counter--;
      }
      _counter--;
      listqwe.add('Нажали -');
      timer5.cancel();
      timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
    });
  }

  late List<String> listqwe;
  String qweeqw = "Првоерка";
  late String Textqwe;

  @override
  void initState() {
    listqwe = [];
    super.initState();
    timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
    SharedPreferences.getInstance().then((value) {
      setState(() {
        if (value.containsKey('count')) {
          _counter = value.getInt('count')!;
        }
        if (value.containsKey('list')) {
          listqwe = value.getStringList('list')!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Textqwe = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'DarkTheme'
        : 'LightTheme';
    if (Textqwe == 'DarkTheme') {
      qwe = 2;
    } else
      qwe = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your gadget have a $Textqwe"),
              Text(""),
              Text(""),
              Text(""),
              Text(
                'How much bebra you have :',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                  onPressed: () {
                    _incrementCounterplus();
                  },
                  child: Text("+")),
              ElevatedButton(
                  onPressed: () {
                    _incrementCounterminus();
                  },
                  child: Text("-")),
              ElevatedButton(onPressed: _saveData, child: Text("Save")),
              ElevatedButton(onPressed: _clearData, child: Text("Clear")),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  ...listqwe
                      .map((element) => ListTile(
                            leading: Icon(Icons.star),
                            title: Text(element),
                          ))
                      .toList()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
