import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tourism/models/city.dart';
import 'package:tourism/models/trip.dart';
import 'package:tourism/models/trip_city.dart';

// String hostUrl = "10.0.2.2:8080";
// String hostUrl = "localhost";
String hostUrl = "tourism-back.onrender.com";

Future<List<City>> fetchCities() async {
  log("in fetchCities ");

  final url = Uri.parse('http://${hostUrl}/cities/?pageNumber=0&pageSize=10');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      log("Successfull ");
      final List<dynamic> citiesJson = jsonDecode(response.body);
      log("Successfull 1");

      var res = citiesJson.map((json) => City.fromJson(json)).toList();

      print('LENGHT = ${res.length}');
      for (var c in res) {
        log("is name null = ${c.name == null}");
        log("is photo null = ${c.phototUri == null}");
      }
      log("Successfull 2");

      return res;
    } else {
      print('Failed to fetch cities. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return [];
    }
  } catch (e) {
    print(e);
  }
  return [];
}

Future<List<Trip>> fetchTrips() async {
  final url = Uri.parse('http://${hostUrl}/trips/');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> tripsJson = jsonDecode(response.body);

      var res = tripsJson.map((json) => Trip.fromJson(json)).toList();

      return res;
    } else {
      print('Failed to fetch trips. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return [];
    }
  } catch (e) {
    print(e);
  }
  return [];
}

Future<List<TripCity>> fetchTripCities(int id) async {
  log("in fetchCities ");

  final url = Uri.parse('http://${hostUrl}/trips/$id/cities');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> citiesJson = jsonDecode(response.body);

      var res = citiesJson.map((json) => TripCity.fromJson(json)).toList();

      return res;
    } else {
      print('Failed to fetch TripCity. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return [];
    }
  } catch (e) {
    print(e);
  }
  return [];
}

Future<bool> postTrip(
    String name, String startDate, String endDate, int userId) async {
  final url = Uri.parse('http://${hostUrl}/trips/');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(      {
        "name": name,
        "startDate": startDate,
        "endDate": endDate,
        "user_id": userId
      },)



    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to post Trip. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  } catch (e) {
    print(e);
  }
  return false;
}
