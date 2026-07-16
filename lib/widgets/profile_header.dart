import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          CircleAvatar(radius: 32),
          SizedBox(width: 16),
          Text('Ime in priimek'),
        ],
      ),
    );
  }
} 