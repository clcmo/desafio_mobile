import 'package:challenge/assets/default.dart';
import 'package:challenge/services/validate.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  late String email, password;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: _buildSignupForm(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.keyboard_return),
          label: const Text('Voltar'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  _buildSignupForm() => Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          const SizedBox(height: 75.0),
          SizedBox(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  const Text('Cadastrar',
                      style:
                          TextStyle(fontFamily: 'Kollektiff', fontSize: 60.0)),
                  //Dot placement
                  Positioned(
                      top: 62.0,
                      left: 200.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Default().color)))
                ],
              )),
          const SizedBox(height: 25.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Kollektif',
                      fontSize: 12.0,
                      color: Colors.blue.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Default().color),
                  )),
              onChanged: (value) => email = value,
              validator: (value) => Default().checkEmail(value)),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'SENHA',
                  labelStyle: TextStyle(
                      fontFamily: 'Kollektif',
                      fontSize: 12.0,
                      color: Colors.blue.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Default().color),
                  )),
              obscureText: true,
              onChanged: (value) => password = value,
              validator: (value) => Default().checkPassword(value)),
          const SizedBox(height: 50.0),
          GestureDetector(
            onTap: () =>
                Validate().verifyFields(context, formKey, email, password),
            child: SizedBox(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Default().colorAccent,
                    color: Default().color,
                    elevation: 7.0,
                    child: const Center(
                        child: Text('CADASTRAR',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Kollektif'))))),
          ),
        ]),
      );
}
