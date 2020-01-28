import 'dart:convert';

import 'package:horaires_ratp/model/Database.dart';
import 'package:horaires_ratp/model/Schedule.dart';
import 'package:http/http.dart' as http;

class StationService {
  Future<List<Station>> getStations(String type, String line, String way) async {
    final response = await http.get(
        "https://api-ratp.pierre-grimaud.fr/v4/stations/${type}/${line}?way=${way}");
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<Station> stations = new List<Station>();
      var result = json["result"];
      List<dynamic> stationsJSON = result["stations"];

      for (var station in stationsJSON) {
        Station s = Station(
            name: station["name"], slug: station["slug"], type: type, way: way, line: line);
        stations.add(s);
      }

      return stations;
    } else {
      throw Exception("Failed to load stations");
    }
  }

  Future<List<Schedule>> getHoraires(Station s) async {
    final response = await http.get(
        "https://api-ratp.pierre-grimaud.fr/v4/schedules/${s.type}/${s.line}/${s.slug}/${s.way}");
    print("https://api-ratp.pierre-grimaud.fr/v4/schedules/${s.type}/${s.line}/${s.slug}/${s.way}");
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<Station> stations = new List<Station>();
      var result = json["result"];
      List<dynamic> schedules = result["schedules"];
      List<Schedule> scheduleResult = new List<Schedule>();

      for (var schedule in schedules) {
        String message =schedule["message"];
        if(message.contains("mn")){
          
          message = message.split(" ")[0];
          scheduleResult.add(Schedule(message,schedule["destination"]));
        }
        else if(message.contains("quai")){
          scheduleResult.add(Schedule("0",schedule["destination"]));
        }
        else{
          scheduleResult.add(Schedule("++",schedule["destination"]));
        }

      }
      return scheduleResult;
    } else {
      throw Exception("Failed to load schedules");
    }
  }
}
