import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fruit_app/data/model/fruit_model.dart';

class FruitApi {
  static const String baseUrl = 'https://www.fruityvice.com/api/fruit';

  Future<List<Fruit>> getAllFruits() async {
    final url = Uri.parse('$baseUrl/all');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки фруктов: ${response.statusCode}');
    }

    final List<dynamic> jsonList = json.decode(response.body);

    return jsonList.map((json) => Fruit.fromJson(json)).toList();
  }
}
