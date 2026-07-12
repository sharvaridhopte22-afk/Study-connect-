import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/joke_model.dart'

class JokeService {
  static const String baseUrl = 'https://v2.jokeapi.dev/joke';

  Future<Joke?> getRandomJoke({String category = 'Any'}) async {
    try {
      final url = category == 'Any'
          ? '$baseUrl/Any?format=json'
          : '$baseUrl/$category?format=json';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['error'] != true) {
          return Joke.fromJson(json);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching joke: $e');
      return null;
    }
  }

  Future<Joke?> getJokeByCategory(String category) async {
    return getRandomJoke(category: category);
  }

  List<String> getCategories() {
    return [
      'Any',
      'General',
      'Programming',
      'Knock-Knock',
      'Custom',
    ];
  }
}
