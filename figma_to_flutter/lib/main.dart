import 'package:flutter/material.dart';
import 'package:figma_to_flutter/button.dart';
import 'button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(
          'You have pushed the button this many times:',
        ),
        Text(
          '$_counter',
          style: Theme
              .of(context)
              .textTheme
              .headline4,
        ),

        ClipRRect(borderRadius: BorderRadius.circular(24),
          child: MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: _incrementCounter,
            child: Container(
              width: 200,
              height: 80,
              child: _ColorCatalog(
                cityscapes_DowntownProvider:
                AssetImage("assets/images/building.png"),
              ),
            ),
          ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
