abstract class Entity {
  String get getId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Entity && other.getId == getId;
  }

  @override
  int get hashCode => getId.hashCode;
}

class ID extends Entity {
  final String id;

  ID(this.id);
  @override
  String get getId => id;
}
