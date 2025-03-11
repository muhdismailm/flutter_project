import 'package:flutter/material.dart';

class WAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const WAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amberAccent,
      title: Text('workify',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: const Icon(Icons.work_rounded),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}