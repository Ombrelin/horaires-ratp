import 'package:flutter/material.dart';
import 'package:horaires_ratp/model/Database.dart';
import 'package:horaires_ratp/service/StationsService.dart';
import 'package:loading/indicator/line_scale_party_indicator.dart';
import 'package:loading/loading.dart';

class _NewStationState extends State<NewStation> {
  final _lineNumberController = TextEditingController();
  String _type;
  String _way;
  List<Station> _stations = List<Station>();
  List<Station> _addedStations = List<Station>();

  final StationService service = new StationService();

  bool _loading = false;

  _NewStationState() {
    _lineNumberController.addListener(_updateStations);
  }

  void _handleChangeType(String value) {
    setState(() {
      this._type = value;
      this._updateStations();
    });
  }

  void _handleChangeWay(String value) {
    setState(() {
      this._way = value;
      this._updateStations();
    });
  }

  void _updateStations() {
    if (this._lineNumberController.text != "" &&
        this._way != null &&
        this._type != null) {
      print("Way : ${this._way}");
      print("Line : ${this._lineNumberController.text}");
      print("Type : ${this._type}");

      setState(() {
        _loading = true;
      });

      service
          .getStations(_type, _lineNumberController.text, _way)
          .then((stations) {
        setState(() {
          _stations = stations;
          _loading = false;
        });
      }).catchError((error) {
        if (context != null) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(error.toString()),
          ));
        }
      });
    }
  }

  void handleClickAdd() {
    for (Station s in _addedStations) {
      print("Adding sation ${s.name}");
      s.save();
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter une station"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: _addedStations.length == 0 ? null : handleClickAdd),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(16),
                    child: DropdownButton<String>(
                      value: _type,
                      hint: Text("Type"),
                      isExpanded: true,
                      items: <String>['metros', 'rers', 'buses']
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: _handleChangeType,
                    )),
                Container(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Numéro de la ligne',
                          border: OutlineInputBorder()),
                      controller: this._lineNumberController,
                      keyboardType: _type == "rers"
                          ? TextInputType.text
                          : TextInputType.number,
                    )),
                Container(
                    padding: EdgeInsets.all(16),
                    child: DropdownButton<String>(
                      value: _way,
                      hint: Text("Sens"),
                      isExpanded: true,
                      items: <String>['A', 'R'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: _handleChangeWay,
                    )),
                _loading
                    ? Loading(
                        indicator: LineScalePartyIndicator(),
                        size: 50.0,
                        color: Colors.greenAccent)
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: ListView.builder(
                            itemCount: _stations.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(_stations[index].name),
                                value:
                                    _addedStations.contains(_stations[index]),
                                onChanged: (value) {
                                  setState(() {
                                    if (value) {
                                      _addedStations.add(_stations[index]);
                                    } else {
                                      _addedStations.remove(_stations[index]);
                                    }
                                  });
                                },
                              );
                            }))
              ],
            ),
          ),
        ));
  }
}

class NewStation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewStationState();
  }
}
