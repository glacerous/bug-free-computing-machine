import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/home_controller.dart';
import '../routes/app_routes.dart';

class SpellsPage extends StatelessWidget {
  SpellsPage({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final FavoriteController favController = Get.find<FavoriteController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Spells Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.toNamed(AppRoutes.favorite),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (homeController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: homeController.items.length,
          itemBuilder: (context, index) {
            final spell = homeController.items[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.auto_fix_high),
                title: Text(spell.spell),
                subtitle: Text(spell.use),
                trailing: Obx(() {
                  final isFav = favController.isFavorite(spell.index);
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.redAccent : Colors.grey,
                    ),
                    onPressed: () => favController.toggleFavorite(spell),
                  );
                }),
              ),
            );
          },
        );
      }),
    );
  }
}
