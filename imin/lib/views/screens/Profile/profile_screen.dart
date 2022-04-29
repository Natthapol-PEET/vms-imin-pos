import 'package:flutter/material.dart';
import 'package:imin/views/screens/ExpansionPanelLayout/expansion_panel_layout.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelScreen(
      child: Expanded(
        flex: 4,
        child: Container(
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
