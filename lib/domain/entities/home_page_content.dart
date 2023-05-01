import 'dart:convert';

class HomePageContent {
  final String name;
  final String id;

  HomePageContent({
    required this.name,
    required this.id,
  });

  HomePageContent copyWith({
    String? name,
    String? id,
  }) {
    return HomePageContent(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory HomePageContent.fromMap(Map<String, dynamic> map) {
    return HomePageContent(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageContent.fromJson(String source) =>
      HomePageContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HomePageContent(name: $name, id: $id)';

  @override
  bool operator ==(covariant HomePageContent other) {
    if (identical(this, other)) return true;

    return other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
