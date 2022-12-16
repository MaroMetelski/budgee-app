import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'transaction.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loggedIn = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void onButton(name, password) async {
      _loggedIn = await Provider.of<Application>(context, listen: false).api.getLogin(name, password);
     if (mounted && _loggedIn) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const EntryPage()),
          (Route<dynamic> route) => false,
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: TextField(
                decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "username",
                ),
                controller: _usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: TextField(
                decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "password",
                ),
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  onButton(_usernameController.text, _passwordController.text);
                },
                child: const Text("log in"),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
