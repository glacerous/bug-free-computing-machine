import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/item_model.dart';
import '../services/notification_service.dart';

// =============================================================================
// FAVORITE CONTROLLER (Modul 6 hal. 104, 117-118 + Modul 8 hal. 157)
// Menyimpan/menghapus ItemModel ke Hive Box 'favorites' secara reaktif.
// =============================================================================

class FavoriteController extends GetxController {
  final Box<ItemModel> _box = Hive.box<ItemModel>('favorites');
  final RxList<ItemModel> _favorites = <ItemModel>[].obs;

  List<ItemModel> get favorites => _favorites;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    _favorites.assignAll(_box.values.toList());
  }

  bool isFavorite(int id) => _favorites.any((e) => e.index == id);

  Future<void> toggleFavorite(ItemModel item) async {
    if (_box.containsKey(item.index)) {
      await _box.delete(item.index);
      Get.snackbar('Remove!', '${item.spell} removed from fav list!', backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      await _box.put(item.index, item);
      Get.snackbar('Add!', '${item.spell} successfully added to fav list!', backgroundColor: Colors.green, colorText: Colors.white);
    }
    loadFavorites();
  }

  Future<void> removeAt(int index) async {
    final spellName = _box.getAt(index)?.spell ?? 'Spell';
    await _box.deleteAt(index);
    loadFavorites();
    await NotificationService().showInstantNotification(
      title: 'Delete notification',
      body: 'You deleted $spellName from your fav list!',
    );
  }
}
