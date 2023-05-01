import 'dart:convert';

class HomePageContent {
  final String name;
  final String path;

  HomePageContent({
    required this.name,
    required this.path,
  });

  HomePageContent copyWith({
    String? name,
    String? path,
  }) {
    return HomePageContent(
      name: name ?? this.name,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'path': path,
    };
  }

  factory HomePageContent.fromMap(Map<String, dynamic> map) {
    return HomePageContent(
      name: map['name'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageContent.fromJson(String source) =>
      HomePageContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HomePageContent(name: $name, path: $path)';

  @override
  bool operator ==(covariant HomePageContent other) {
    if (identical(this, other)) return true;

    return other.name == name && other.path == path;
  }

  @override
  int get hashCode => name.hashCode ^ path.hashCode;
}
