import 'package:challenge/assets/default.dart';
import 'package:challenge/services/auth_services.dart';
import 'package:challenge/services/validate.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final formKey = GlobalKey<FormState>();
  late String email;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildResetForm())),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.keyboard_return),
          label: const Text('Voltar'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  _buildResetForm() => Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(children: [
        const SizedBox(height: 75.0),
        SizedBox(
            height: 125.0,
            width: 200.0,
            child: Stack(
              children: [
                const Text('Esqueci Minha Senha',
                    style: TextStyle(fontFamily: 'Kollektif', fontSize: 40.0)),
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
        const SizedBox(height: 50.0),
        GestureDetector(
          onTap: () {
            if (Validate().checkFields(formKey)) {
              AuthService().resetPasswordLink(email);
            }
            Navigator.of(context).pop();
          },
          child: SizedBox(
              height: 50.0,
              child: Material(
                  borderRadius: BorderRadius.circular(25.0),
                  shadowColor: Default().colorAccent,
                  color: Default().color,
                  elevation: 7.0,
                  child: const Center(
                      child: Text('RECUPERAR SENHA',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Kollektif'))))),
        )
      ]));
}
