import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = false,
    this.paddingHorizontal = 15,
    this.backGroundColor,
    this.leading,
    this.showBackArrow = true,
  });

  final Widget title;
  final List<Widget>? actions;
  final bool? centerTitle;
  final double paddingHorizontal;
  final Color? backGroundColor;
  final Widget? leading;
  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: AppBar(
        backgroundColor: backGroundColor,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Iconsax.arrow_left),
              )
            : leading,
        title: title,
        centerTitle: centerTitle,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );
}
