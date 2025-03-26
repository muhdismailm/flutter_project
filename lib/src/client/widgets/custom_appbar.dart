import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      toolbarHeight: 80,
      title: Text('WORKIFY',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: const Icon(Icons.work_outline,color: Colors.white,),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}