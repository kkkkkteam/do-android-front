import 'package:flutter/material.dart';

class AuthInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const AuthInfoRow({required this.title, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 14)),
          Text(value, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
