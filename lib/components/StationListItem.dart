import 'package:flutter/material.dart';
import 'package:horaires_ratp/model/Database.dart';
import 'package:horaires_ratp/model/Schedule.dart';
import 'package:horaires_ratp/service/StationsService.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/line_scale_party_indicator.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';
import 'package:loading/loading.dart';

class StationListItem extends StatefulWidget {
  final Station _station;
  final Function _handleDelete;

  StationListItem(this._station, this._handleDelete);

  @override
  State<StatefulWidget> createState() {
    return StationListItemState(_station, _handleDelete);
  }
}

class StationListItemState extends State<StationListItem> {
  final Station _station;
  final Function _handleDelete;
  bool _loading = true;
  List<Schedule> _schedules = List<Schedule>();
  StationService _service = StationService();
  String _destination = "";

  StationListItemState(this._station, this._handleDelete) {
    _service.getHoraires(_station).then((schedules) {
      setState(() {
        _schedules = schedules;
        _loading = false;
        _destination = schedules[0].destination;
      });
    });
  }

  void _updateSchedules() {
    setState(() {
      _loading = true;
    });

    _service.getHoraires(_station).then((schedules) {
      setState(() {
        _schedules = schedules;
        _destination = schedules[0].destination;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(_station.name,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left),
                    IconButton(
                        icon: Icon(Icons.loop),
                        onPressed: _loading ? null : () => _updateSchedules()),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _handleDelete(_station)),
                  ],
                ),
                Text("${_station.type.substring(0, )} ${_station.line} direction ${_destination}",
                    style: TextStyle(
                        color: Colors.white70, fontStyle: FontStyle.italic)),
                _loading
                    ? Loading(
                        indicator: LineScalePartyIndicator(),
                        size: 25.0,
                        color: Colors.greenAccent)
                    : Row(
                        children: _schedules.map((e) {
                          return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            margin: EdgeInsets.fromLTRB(0, 16, 16, 0),
                            elevation: 10,
                              child: Container(
                                  width: 48,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                      borderRadius: BorderRadius.circular(3)
                                  ),
                                  child: Text(e.message,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))));
                        }).toList(),
                      )
              ],
            )),
      ),
    );
  }
}
