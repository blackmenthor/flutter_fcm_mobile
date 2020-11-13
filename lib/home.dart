import 'package:flutter/material.dart';
import 'package:flutter_fcm_mobile/fcm.dart';

class HomePage extends StatelessWidget {
  HomePage() {
    initFcm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('This is home page!'),
      ),
    );
  }
}
