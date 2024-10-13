import 'package:flutter/material.dart';

import '../../../controller/product_controller.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.controller,
  });

  final ProductController controller;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('All Products'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: widget.controller.searchController,
            onChanged: (value) {
              widget.controller.filterProducts(value);
              setState(() {});
            },
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus!.unfocus(),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: widget.controller.searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        widget.controller.clearSearchQuery();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    )
                  : const SizedBox.shrink(),
              hintText: 'Search product',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade300,
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}
