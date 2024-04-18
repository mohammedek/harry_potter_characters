import 'package:dio/dio.dart';

import '../models/characters.dart';  // Assuming the file is named characters.dart

class CharacterService {
  final Dio _dio = Dio();

  Future<List<Character>> fetchCharacters() async {
    try {
      final response =
      await _dio.get('https://hp-api.onrender.com/api/characters');
      final List<dynamic> data = response.data;
      return data.map((json) => Character.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load characters: $error');
    }
  }
}