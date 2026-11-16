import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../routes/app_routes.dart';

// =============================================================================
// HOME PAGE - GRID / LIST DATA API (Modul 8 hal. 171-173, 179)
// =============================================================================

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Terhubung ke HomeController (punya getter `items` untuk Spells & `characters` untuk Characters)
  final HomeController controller = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // [ENABLE SEARCH] Uncomment blok TextField di bawah jika soal butuh Search bar:
            // TextField(
            //   onChanged: controller.search,
            //   decoration: const InputDecoration(
            //     hintText: 'Cari...',
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  itemCount: controller.characters.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    // `item` = 1 CharacterModel dari getter `controller.characters` di HomeController
                    final item = controller.characters[index];
                    return GestureDetector(
                      // TODO: Ganti `item.index` jadi `item` agar DetailPage langsung terima CharacterModel
                      onTap: () =>
                          Get.toNamed(AppRoutes.detail, arguments: item),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: item.image.isNotEmpty
                                  ? Image.network(
                                      item.image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Icon(Icons.image, size: 48)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.fullName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('⭐ ${item.interpretedBy}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
