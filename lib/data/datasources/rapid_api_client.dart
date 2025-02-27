import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as https;

import '../../core/keys.dart';
import '../models/fetched_file.dart';

class RapidApiClient {
  Future<List<FecthedFile>> getFiles({
    int page = 1,
    String search = 'car',
  }) async {
    // try {

    final response = await https.get(
        Uri.parse(
          'https://free-images-api.p.rapidapi.com/v2/${search}/${page.toString()}',
        ),
        headers: {
          'x-rapidapi-key': rapidAPIKey,
          'x-rapidapi-host': rapidAPIHost,
        });

    if (response.statusCode == 200) {
      Map content = json.decode(
        utf8.decode(response.bodyBytes),
      );
      log("Reposne : ${content}");
      final List<FecthedFile> photos =
          List<Map<String, dynamic>>.from(content['results'])
              .map((e) => FecthedFile.fromMap(e))
              .toList();
      return photos;
    } else {
      throw Exception('Failed to fetch files');
    }
    // } catch (e) {
    //   throw Exception('API Error: $e');
    // }
  }
}
