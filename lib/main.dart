import 'package:flutter/material.dart';
import 'package:flutter_fcm_mobile/home.dart';
import 'package:flutter_fcm_mobile/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void _loginUser(BuildContext context) async {
    String phone = phoneCtrl.text;
    String password = passwordCtrl.text;

    if (phone.isNotEmpty && password.isNotEmpty) {
      // HIT THE API
      final urlPath = 'http://10.0.2.2:8000/api-token-auth/';
      final data = {
        "phone_number": phone,
        "password": password,
      };

      final resp = await dio.post(urlPath, data: data);

      final token = resp.data['token'];
      globalToken = token;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: phoneCtrl,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: passwordCtrl,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                  child: Text('LOGIN'),
                  onPressed: () {
                    _loginUser(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
