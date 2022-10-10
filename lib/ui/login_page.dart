import 'package:challenge/assets/default.dart';
import 'package:challenge/services/auth_services.dart';
import 'package:challenge/services/validate.dart';
import 'package:challenge/ui/reset_page.dart';
import 'package:challenge/ui/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late String email, password;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: _buildLoginForm(),
          )));
  _buildLoginForm() => Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          const SizedBox(height: 75.0),
          SizedBox(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  const Text('Oi, faça seu',
                      style:
                          TextStyle(fontFamily: 'Kollektif', fontSize: 40.0)),
                  const Positioned(
                      top: 50.0,
                      child: Text('Login',
                          style: TextStyle(
                              fontFamily: 'Kollektif', fontSize: 40.0))),
                  Positioned(
                      top: 97.0,
                      left: 250.0,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Default().color),
                      ))
                ],
              )),
          const SizedBox(height: 45.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'E-mail'.toUpperCase(),
                  labelStyle: TextStyle(
                      fontFamily: 'Kollektif',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Default().color),
                  )),
              onChanged: (value) => email = value,
              validator: (value) => Default().checkEmail(value)),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Senha'.toUpperCase(),
                labelStyle: TextStyle(
                    fontFamily: 'Kollektif',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Default().color),
                )),
            obscureText: true,
            onChanged: (value) => password = value,
            validator: (value) => Default().checkPassword(value),
          ),
          const SizedBox(height: 5.0),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ResetPage())),
            child: Container(
                alignment: const Alignment(1.0, 0.0),
                padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                child: InkWell(
                    child: Text(
                  'Esqueceu a Senha',
                  style: TextStyle(
                      color: Default().color,
                      fontFamily: 'Kollektif',
                      fontSize: 12.0,
                      decoration: TextDecoration.underline),
                ))),
          ),
          const SizedBox(height: 70.0),
          GestureDetector(
            onTap: () => Validate()
                .verifyFieldsToLogin(context, formKey, email, password),
            child: SizedBox(
              height: 50.0,
              child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Default().colorAccent,
                  color: Default().color,
                  elevation: 7.0,
                  child: const Center(
                      child: Text(
                    'LOGIN',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Kollektif'),
                  ))),
            ),
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
              onTap: () => AuthService().loginFB(),
              child: Container(
                height: 50.0,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2.0),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(child: Icon(Icons.facebook, size: 15.0)),
                        SizedBox(width: 10.0),
                        Center(
                            child: Text('Login com facebook',
                                style: TextStyle(fontFamily: 'Kollektif')))
                      ],
                    )),
              )),
          const SizedBox(height: 65.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Novo aqui?'),
            const SizedBox(width: 5.0),
            InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignUpPage())),
                child: Text('Registrar',
                    style: TextStyle(
                        color: Default().color,
                        fontFamily: 'Kollektif',
                        decoration: TextDecoration.underline)))
          ])
        ],
      ));
}
