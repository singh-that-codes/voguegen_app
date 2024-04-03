import 'package:http/http.dart' as http;
import 'dart:convert';

class PexelsService {
  final String apiKey =
      'kGS14s0fxGcDEEYRIffTaBqk7MaHV3QfPwbHDJN12NVbpqk2maypAMSf';

  Future<List<String>> searchImages(String query) async {
    final url =
        Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=1');
    final response = await http.get(url, headers: {'Authorization': apiKey});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<String> imageUrls = [];
      for (var item in data['photos']) {
        String url = item['src']['medium'];
        imageUrls.add(url);
      }
      return imageUrls;
    } else {
      // Handle error or throw an exception
      throw Exception('Failed to load images from Pexels');
    }
  }
}
