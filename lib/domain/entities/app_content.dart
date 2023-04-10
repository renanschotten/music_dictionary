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
