class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String? bio;
  final List<String> interests;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.bio,
    required this.interests,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      interests: List<String>.from(json['interests'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'bio': bio,
      'interests': interests,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
