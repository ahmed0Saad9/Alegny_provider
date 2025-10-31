import 'package:flutter/material.dart';


class CloseIconWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  const CloseIconWidget({
    super.key, required this.onTap, this.size=20,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(.32),
        radius: size,
        child:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
                  Icons.close,
                  color: Colors.white,
                  size: size,
                ),
          ],
        ),
      ),
    );
  }
}
