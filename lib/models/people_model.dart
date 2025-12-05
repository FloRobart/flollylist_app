class People {
  final int id;
  final String firstName;
  final String? lastName;
  final String? dateOfBirth; // ISO 8601 date string or null
  final int userId;
  final String createdAt;
  final String updatedAt;

  People({
    required this.id,
    required this.firstName,
    this.lastName,
    this.dateOfBirth,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] == null ? null : json['last_name'] as String,
      dateOfBirth: _parseDateOfBirth(json['date_of_birth']),
      userId: json['user_id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

String? _parseDateOfBirth(dynamic raw) {
  if (raw == null) return null;
  if (raw is String) return raw;
  if (raw is int) {
    try {
      // raw could be seconds or milliseconds since epoch
      if (raw > 9999999999) {
        // milliseconds
        return DateTime.fromMillisecondsSinceEpoch(raw).toIso8601String();
      } else {
        // seconds
        return DateTime.fromMillisecondsSinceEpoch(raw * 1000).toIso8601String();
      }
    } catch (e) {
      return raw.toString();
    }
  }
  return raw.toString();
}
