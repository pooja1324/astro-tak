import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:india_today_assignment/api_calls/end_points.dart';

class ApiCalls {
  static Map<String, String> getHeader() {
    return {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyVHlwZSI6IlVTRVIiLCJ1dWlkIjoiODZhYTlhODItYjlhOS00NGFiLTkyYzQtODY4YjIyYzA4ZTY0IiwiaXNFbWFpbFZlcmlmaWVkIjp0cnVlLCJwaG9uZU51bWJlciI6Ijg4MDk3NjUxOTEiLCJlbWFpbCI6ImFiaGlzaGVrLnNhaEBhYWp0YWsuY29tIiwibWFza2VkRW1haWwiOiJhYmgqKioqKioqKiphYWp0YWsuY29tIiwiZXhpc3RpbmdVc2VyIjpmYWxzZSwiaWF0IjoxNjQ3OTQ1MjY3LCJleHAiOjE2Njc5NDUyNjd9.whYbyeeBt91qni3zzp5eaitD2eKVnPI5scjiG49J_ks',
      'Content-Type': 'application/json'
    };
  }

  static Future<String> fetchCategories() async {
    try {
      var response = await http.get(Uri.https(
        EndPoints.baseUri,
        EndPoints.allCategories,
      ));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Something went wrong';
      }
    } on SocketException catch (e) {
      throw 'No Internet Connection';
    }
  }

  static Future<String> fetchRelatives() async {
    try {
      var response = await http.get(
          Uri.https(
            EndPoints.baseUri,
            EndPoints.allRelative,
          ),
          headers: getHeader());
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Something went wrong';
      }
    } on SocketException catch (e) {
      throw 'No Internet Connection';
    }
  }

  static Future<String> fetchPlaces(String initials) async {
    try {
      var response = await http.get(Uri.parse(
        EndPoints.baseUrl + EndPoints.places + initials,
      ));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Something went wrong';
      }
    } on SocketException catch (e) {
      throw 'No Internet Connection';
    }
  }

  static Future<String> addRelative(Map<String, dynamic> body) async {
    try {
      var response = await http.post(
          Uri.parse(
            EndPoints.baseUrl + EndPoints.relative,
          ),
          body: json.encode(body),
          headers: getHeader());
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Something went wrong';
      }
    } on SocketException catch (e) {
      throw 'No Internet Connection';
    }
  }
  static Future<String> deleteRelative(String uuid) async {
    try {
      var response = await http.post(Uri.parse(
        EndPoints.baseUrl + EndPoints.delete + uuid,
      ), headers: getHeader());
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Something went wrong';
      }
    } on SocketException catch (e) {
      throw 'No Internet Connection';
    }
  }

  static Future<String> updateRelative(Map<String, dynamic> body) async {
    try {
      var response = await http.post(
          Uri.parse(
            EndPoints.baseUrl + EndPoints.update+body['uuid'],
          ),
          body: json.encode(body),
          headers: getHeader());
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Something went wrong';
      }
    } on SocketException catch (e) {
      throw 'No Internet Connection';
    }
  }
}
