class Joke {
  final String id;
  final String category;
  final String type; // 'single' or 'twopart'
  final String joke;
  final String? setup;
  final String? delivery;
  final bool safe;
  DateTime? savedAt;

  Joke({
    required this.id,
    required this.category,
    required this.type,
    required this.joke,
    this.setup,
    this.delivery,
    required this.safe,
    this.savedAt,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'].toString(),
      category: json['category'] as String,
      type: json['type'] as String,
      joke: json['joke'] as String?,
      setup: json['setup'] as String?,
      delivery: json['delivery'] as String?,
      safe: json['safe'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'type': type,
      'joke': joke,
      'setup': setup,
      'delivery': delivery,
      'safe': safe,
      'savedAt': savedAt?.toIso8601String(),
    };
  }

  String getFullText() {
    if (type == 'twopart') {
      return '$setup\n\n$delivery';
    }
    return joke ?? '';
  }
}
