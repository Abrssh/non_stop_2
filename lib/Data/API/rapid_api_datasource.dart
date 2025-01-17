import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RapidApiDatasource {
  Future<List<dynamic>> fetchAlbums(
      {String query = "Ethiopian", int limit = 20}) async {
    final apiKey = dotenv.env["rapid_api_key"];
    final String endPoint =
        "https://spotify23.p.rapidapi.com/search/?q=$query&type=albums&offset=0&limit=$limit&numberOfTopResults=5";

    try {
      final response = await http.get(Uri.parse(endPoint), headers: {
        "X-RapidAPI-Key": apiKey!,
        "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['albums']['items'];
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized access. API needs to be Updated.");
      } else if (response.statusCode == 403 || response.statusCode == 429) {
        throw Exception("API limit exceeded. Please try again later.");
      } else if (response.statusCode == 404) {
        throw Exception("Data not found. API endpoint may have changed.");
      } else if (response.statusCode == 500) {
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception(
            "Failed to fetch players. Error code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch albums");
    }
  }
}
