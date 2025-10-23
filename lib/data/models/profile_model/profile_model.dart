class Profile {
  final String name;
  final String email;

  Profile({required this.name, required this.email});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
