import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';

class CustomIconFav extends StatelessWidget {
  final VoidCallback onTap;
  final bool isFav;
  const CustomIconFav({
    super.key,
    required this.onTap,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: IconSvg(
        isFav ? 'favorite' : 'un_favorite',
        size: 28,
      ),
    );
  }
}
