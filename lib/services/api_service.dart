import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';

class ApiService {
  Future<ApiResponse> fetchApiResponse() async {
    final response = await http.get(Uri.parse('https://www.tcs.com/content/dam/global-tcs/en/worldwide-json/worldwide-map-5-12.json'));

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load API response');
    }
  }
}