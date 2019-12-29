import 'package:flutter/material.dart';
import 'package:horaires_ratp/service/StationsService.dart';

class _NewStationState extends State<NewStation> {
  final _lineNumberController = TextEditingController();
  String _type;
  String _way;

  final StationService service = new StationService();

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
      try{
        service.getStations(_type, int.parse(_lineNumberController.text), _way);
      }
      catch(e){
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString()),));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une station"),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.check), onPressed: () {}),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(16),
                child: DropdownButton<String>(
                  value: _type,
                  hint: Text("Type"),
                  isExpanded: true,
                  items: <String>['metros', 'rers', 'buses'].map((String value) {
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
                  keyboardType: TextInputType.number,
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
          ],
        ),
      ),
    );
  }
}

class NewStation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewStationState();
  }
}
