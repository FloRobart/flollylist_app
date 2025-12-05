class Gift {
  final int id;
  final String name;
  final String? description;
  final int? year;
  final String? link;
  final int personId;
  final int userId;

  Gift({
    required this.id,
    required this.name,
    this.description,
    this.year,
    this.link,
    required this.personId,
    required this.userId,
  });

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json['id'],
      name: json['gift_name'],
      description: json['gift_description'],
      year: json['gift_year'],
      link: json['link'],
      personId: json['people_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gift_name': name,
      'gift_description': description,
      'gift_year': year,
      'link': link,
      'people_id': personId,
      'user_id': userId,
    };
  }
}