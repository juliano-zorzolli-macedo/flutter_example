import 'package:flutter/material.dart';

class DSAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const DSAvatar({super.key, this.imageUrl, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
      ),
      child: imageUrl == null
          ? Icon(Icons.person, color: Colors.grey[600], size: size * 0.6)
          : null,
    );
  }
}