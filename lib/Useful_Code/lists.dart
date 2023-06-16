import 'entity.dart';

extension CustomMethods on List<Entity> {
  bool hasItem(Entity item) {
    final itemIndex = indexWhere((element) => element.getId == item.getId);

    if (itemIndex == -1) {
      return false;
    }

    return true;
  }

   bool hasId(String id) {
    final itemIndex = indexWhere((element) => element.getId == id);

    if (itemIndex == -1) {
      return false;
    }

    return true;
  }

  Entity getItemById(String id) {
    final itemIndex = indexWhere((element) => element.getId == id);

    if (itemIndex == -1) {
      return null;
    }

    return this[itemIndex];
  }

  bool updateItem(Entity newItemData) {
    final itemIndex =
        indexWhere((element) => element.getId == newItemData.getId);

    if (itemIndex == -1) {
      return false;
    }

    this[itemIndex] = newItemData;
    return true;
  }
}
