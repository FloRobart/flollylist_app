class UserProfile {
  final int id;
  final String email;
  final String pseudo;
  final bool isConnected;
  final bool isVerifiedEmail;
  final DateTime createdAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.pseudo,
    required this.isConnected,
    required this.isVerifiedEmail,
    required this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      pseudo: json['pseudo'],
      // Mapping des champs boolean et date depuis l'API
      isConnected: json['is_connected'] ?? false,
      isVerifiedEmail: json['is_verified_email'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}