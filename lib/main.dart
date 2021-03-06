import 'package:flutter/material.dart';
import 'package:horaires_ratp/model/Database.dart';
import 'components/NewStation.dart';
import 'components/StationsList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isInitialized = await StationsModel().initializeDB();
  if (isInitialized == true){
    runApp(MyApp());
  } else {

  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horaires RATP',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark
      ),
      home: MyHomePage(title: 'Horaires RATP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return StationsList();
  }
}
