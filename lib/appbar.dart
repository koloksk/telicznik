import 'package:flutter/material.dart';

class PublicAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PublicAppBar({Key? key}) : super(key: key);

  @override
  _PublicAppBar createState() => _PublicAppBar();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _PublicAppBar extends State<PublicAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      leading: Builder(
        builder: (context) => // Ensure Scaffold is in context
            IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer()),
      ),
    );
  }
}
