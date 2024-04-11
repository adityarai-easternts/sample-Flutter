class Dog {
  final String name;

  Dog({
    required this.name,
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return "Dog{name: $name}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
