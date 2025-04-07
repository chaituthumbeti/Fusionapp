import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String role;
  const ProfilePage({super.key,required this.role});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Page of $role',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
