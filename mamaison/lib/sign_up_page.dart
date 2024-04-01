import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mamaison/api/data_api.dart';
import 'package:mamaison/login_page.dart';
import 'package:mamaison/widgets/input_field.dart';

import 'models/data_post.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _name = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _password = TextEditingController();
  final _id = TextEditingController();
  bool success = false;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsetsDirectional.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "Enregistrement",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text("Créer votre compte",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 50),
          InputField(
              text: _name,
              icon: Icons.person,
              hint: "Nom et Prénom",
              errorText: showError ? "Nom ou prénom invalide" : null,
              obscureText: false),
          SizedBox(height: 10),
          InputField(
              text: _emailController,
              icon: Icons.email,
              hint: "Email",
              errorText: showError ? "Email invalide" : null,
              obscureText: false),
          SizedBox(
            height: 10,
          ),
          InputField(
              text: _phoneNumber,
              icon: Icons.phone,
              hint: "Numéro de téléphone",
              errorText: showError ? "Numéro de téléphone invalide" : null,
              obscureText: false),
          SizedBox(
            height: 10,
          ),
          InputField(
              text: _password,
              icon: Icons.password,
              hint: "Mot de passe",
              errorText: showError ? "Mot de passe invalide" : null,
              obscureText: true),
          SizedBox(height: 10),
          InputField(
              text: _id,
              icon: Icons.numbers,
              hint: "Id d'inscription",
              errorText: showError ? "Id invalide" : null,
              obscureText: false),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              const String apiUrl = DataApi.saveUserUrl;
              Map<String, dynamic> userData = {
                "name": _name.text,
                "email": _emailController.text,
                "phone_number": _phoneNumber.text,
                "password": _password.text,
                "id": _id.text
              };
              String jsonBody = jsonEncode(userData);

              success = await DataPost()
                  .sendPostRequest(context, jsonBody, Uri.parse(apiUrl));
              if (success) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Scaffold(body: LoginPage())));
              } else {}
            },
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("S'inscrire")),
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(), padding: EdgeInsetsDirectional.all(20)
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
                  builder: (context) => Scaffold(body: LoginPage()),
                ),
              );
            },
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("Se connecter")),
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(), padding: EdgeInsetsDirectional.all(20)
                //padding: EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 20),
                ),
          ),
        ],
      ),
    ));
  }
}
