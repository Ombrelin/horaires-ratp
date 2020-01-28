import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horaires_ratp/components/NewStation.dart';
import 'package:horaires_ratp/components/StationListItem.dart';
import 'package:horaires_ratp/model/Database.dart';

class StationsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StationsListState();
  }
}

class _StationsListState extends State<StationsList> {
  List<Station> _stations = List<Station>();

  _StationsListState() {
    updateStationList();
  }

  Future<void> updateStationList() async {
    List<Station> stations = await Station().select().toList();
    setState(() {
      _stations = stations;
    });
  }

  void _handleStationDelete(Station station) {
    station.delete(true);
    updateStationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Horaires RATP"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
            child: ListView.builder(
                itemCount: _stations.length,
                itemBuilder: (context, index) {
                  return StationListItem(
                      _stations[index], _handleStationDelete);
                })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewStation()),
          ).then((value) {
            updateStationList();
          })
        },
        tooltip: 'Ajouter une station',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
