import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mamaison/api/data_api.dart';
import 'package:mamaison/dashboard.dart';
import 'package:mamaison/models/data_post.dart';
import 'package:mamaison/sign_up_page.dart';
import 'package:mamaison/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _NewLoginPage();
  }
}

class _NewLoginPage extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool success = false;
  bool showError = false;
  bool _isAutenticating = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bienvenue",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 70),
          InputField(
              text: _emailController,
              icon: Icons.person,
              hint: "Nom d'utilisateur",
              errorText: showError ? "Nom d'utilisateur invalide" : null,
              obscureText: false),
          SizedBox(height: 20),
          InputField(
              text: _passwordController,
              icon: Icons.password,
              hint: "Mot de passe",
              errorText: showError ? "Mot de passe invalide" : null,
              obscureText: true),
          SizedBox(height: 20),
          if (_isAutenticating) const CircularProgressIndicator(),
          if (!_isAutenticating)
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isAutenticating = true;
                    });
                    const String apiUrl =
                        DataApi.getUserUrl;
                    Map<String, dynamic> userData = {
                      "email": _emailController.text,
                      "password": _passwordController.text
                    };
                    String jsonBody = jsonEncode(userData);

                    success = await DataPost()
                        .sendPostRequest(context, jsonBody, Uri.parse(apiUrl));
                    if (success) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    } else {
                      setState(() {
                        setState(() {
                          _isAutenticating = false;
                        });
                        showError = true;
                      });
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text("Se connecter")),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsetsDirectional.all(20)
                      //padding: EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 20),
                      ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(body: SignUpPage()),
                      ),
                    );
                  },
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text("S'inscrire")),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsetsDirectional.all(20)
                      //padding: EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 20),
                      ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
