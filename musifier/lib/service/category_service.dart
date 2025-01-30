import 'package:dio/dio.dart';
import '../models/category.dart';

class CategoryService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://musifier.circles-dev.tech/server/categories?relations[playlists]=true";

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await _dio.get(_baseUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = ((response.data['data'] ?? []) as List);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }
}
