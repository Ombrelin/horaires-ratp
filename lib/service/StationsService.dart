import 'dart:convert';

import 'package:horaires_ratp/components/StationsList.dart';
import 'package:horaires_ratp/model/Database.dart';
import 'package:http/http.dart' as http;

class StationService {
  Future<List<Station>> getStations(String type, int line, String way) async {
    final response = await http.get(
        "https://api-ratp.pierre-grimaud.fr/v4/stations/${type}/${line}?way=${way}");
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      List<Station> stations = new List<Station>();
      var result = json["result"];
      List<dynamic> stationsJSON = result["stations"];

      for (var station in stationsJSON) {
        Station s = Station(name: station["name"], slug: station["slug"]);
        stations.add(s);
      }

      return stations;
    } else {
      throw Exception("Failed to load stations");
    }
  }
}
