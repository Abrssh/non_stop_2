import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RapidApiDatasource {
  Future<List<dynamic>> fetchGroupData(
      {String query = "Ethiopian",
      int limit = 20,
      String type = "albums"}) async {
    final apiKey = dotenv.env["rapid_api_key"];
    final String endPoint =
        "https://spotify23.p.rapidapi.com/search/?q=$query&type=$type&offset=0&limit=$limit&numberOfTopResults=20";

    try {
      final response = await http.get(Uri.parse(endPoint), headers: {
        "X-RapidAPI-Key": apiKey!,
        "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint("Fetched data: ${data[type]['items'].length} type: $type");
        return data[type]['items'];
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
            "Failed to fetch Albums. Error code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch Group Data. Error info: $e");
    }
  }

  Future<List<dynamic>> fetchArtistAlbums(String artistId) async {
    final apiKey = dotenv.env["rapid_api_key"];
    final String endPoint =
        "https://spotify23.p.rapidapi.com/artist_albums/?id=$artistId&offset=0&limit=300";

    try {
      final response = await http.get(Uri.parse(endPoint), headers: {
        "X-RapidAPI-Key": apiKey!,
        "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']['artist']['discography']['albums']['items'];
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
            "Failed to fetch Albums. Error code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch Artist Albums");
    }
  }

  Future<List<dynamic>> fetchAlbumTracks(String albumId) async {
    final apiKey = dotenv.env["rapid_api_key"];
    final String endPoint =
        "https://spotify23.p.rapidapi.com/album_tracks/?id=$albumId&offset=0&limit=300";

    try {
      final response = await http.get(Uri.parse(endPoint), headers: {
        "X-RapidAPI-Key": apiKey!,
        "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']['album']['tracks']['items'];
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
            "Failed to fetch Tracks. Error code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch Album Tracks");
    }
  }
}
