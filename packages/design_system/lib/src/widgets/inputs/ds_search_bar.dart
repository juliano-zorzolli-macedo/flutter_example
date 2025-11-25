import 'package:flutter/material.dart';

class DSSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool readOnly;

  const DSSearchBar({
    super.key,
    this.hintText = 'Buscar',
    this.onTap,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Expanded(
              child: readOnly
                  ? Text(
                hintText,
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              )
                  : TextField(
                controller: controller,
                decoration: InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}