import 'package:flutter/material.dart';
import 'package:imin/views/screens/ExpansionPanelLayout/expansion_panel_layout.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

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
