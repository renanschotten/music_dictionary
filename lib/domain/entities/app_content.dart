import 'dart:convert';

class AppContent {
  final String name;
  final String path;

  AppContent({
    required this.name,
    required this.path,
  });

  AppContent copyWith({
    String? name,
    String? path,
  }) {
    return AppContent(
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

  factory AppContent.fromMap(Map<String, dynamic> map) {
    return AppContent(
      name: map['name'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppContent.fromJson(String source) =>
      AppContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AppContent(name: $name, path: $path)';

  @override
  bool operator ==(covariant AppContent other) {
    if (identical(this, other)) return true;

    return other.name == name && other.path == path;
  }

  @override
  int get hashCode => name.hashCode ^ path.hashCode;
}
