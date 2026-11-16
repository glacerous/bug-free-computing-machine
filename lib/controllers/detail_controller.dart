import 'package:get/get.dart';
import '../models/item_model.dart';

// =============================================================================
// DETAIL CONTROLLER (Modul 8 hal. 179-180 & Modul 5 hal. 93-94, 100)
// Mengambil id dari Get.arguments, lalu fetch detail dari API.
// =============================================================================

class DetailController extends GetxController {
  final Rx<CharacterModel?> _item = Rx<CharacterModel?>(null);
final RxBool _isLoading = true.obs;

CharacterModel? get item => _item.value;
bool get isLoading => _isLoading.value;

@override
void onInit() {
  super.onInit();
  _item.value = Get.arguments as CharacterModel;
  _isLoading.value = false;
}

}
