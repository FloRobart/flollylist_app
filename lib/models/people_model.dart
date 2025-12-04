class People {
  final int id;
  final String name;
  final String? description;
  final int? year;
  final String? link;
  final int personId; // Wait, based on analysis, this might be redundant or specific ID logic
  final int userId;

  People({
    required this.id,
    required this.name,
    this.description,
    this.year,
    this.link,
    required this.personId,
    required this.userId,
  });

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      id: json['id'],
      name: json['people_name'],
      description: json['people_description'],
      year: json['people_year'],
      link: json['link'],
      personId: json['person_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'people_name': name,
      'people_description': description,
      'people_year': year,
      'link': link,
      'person_id': personId,
      'user_id': userId,
    };
  }
}