import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/config.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppbar({required this.drawerController, super.key});
  final ZoomDrawerController drawerController;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white70,
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        onPressed: () {
          drawerController.toggle?.call();
        },
        icon: const Icon(Icons.menu),
      ),
      title: const Text(
        "Aktüel Market Katalogları",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
