import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Station().select().toList().then((value) {
      setState(() {
        _stations.addAll(_stations);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: _stations.length,
            itemBuilder: (context, index) {
              return StationComponent(
                  _stations[index].name, _stations[index].slug);
            }));
  }
}

class StationComponent extends StatelessWidget {
  String _name;
  String _slug;

  StationComponent(String this._name, String this._slug);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_name, textAlign: TextAlign.left),
                Column(
                  children: <Widget>[Row(children: <Widget>[])],
                )
              ],
            )),
      ),
    );
  }
}
