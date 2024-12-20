import "package:flutter/material.dart";

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leadingIcon;
  final Widget title;
  final MainAxisAlignment mainAxisAlignment;
  
  const MyAppbar({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.mainAxisAlignment,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // actions: [
      //   IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
      // ],
      title: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          leadingIcon,
          const SizedBox(width: 8),
          title
        ],
      ),
      backgroundColor: Color(0xFFBC3B3B),
    );
  }
}