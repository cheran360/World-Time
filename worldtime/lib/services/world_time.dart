import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the ui
  late String time; //time in that location
  String flag; // url to an asset flag icon
  String url; //url location for api end point
  late bool isDaytime; // true or false if daytime

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data)

      //get properties from data
      String datetime = data['datetime'];
      String offseth = data['utc_offset'].substring(0, 3);
      String offsetm = data['utc_offset'].substring(4, 6);
      // print(datetime);
      // print(offset);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offseth), minutes: int.parse(offsetm)));

      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now); //set the time property

    } catch (e) {
      time = 'not a valid data';
    }
  }
}
