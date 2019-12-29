import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StationsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StationsListState();
  }
}

class _StationsListState extends State<StationsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[Station()],
    ));
  }
}

class Station extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Test Station", textAlign: TextAlign.left),
                Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text('Bus 180 \t'),
                      Text("2\t"),
                      Text("12\t")
                    ])
                  ],
                )
              ],
            )),
      ),
    );
  }
}
