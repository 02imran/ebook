import 'package:ebook/authentication/firebase_login.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:ebook/utils/fire_auth.dart';
import 'package:ebook/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Register Form '),
        ),
        body: buildRegisterForm(context),
      ),
    );
  }

  buildRegisterForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 150,
                        child:
                            Center(child: Image.asset('assets/ebooklogo.jpg')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Register Form " + '',
                        style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextFormField(
                      controller: _nameTextController,
                      focusNode: _focusName,
                      validator: (value) => Validator.validateName(
                        name: value,
                      ),
                      decoration: InputDecoration(
                        hintText: "Name",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailTextController,
                      focusNode: _focusEmail,
                      validator: (value) => Validator.validateEmail(
                        email: value,
                      ),
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordTextController,
                      focusNode: _focusPassword,
                      obscureText: true,
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.0),
                    _isProcessing
                        ? CircularProgressIndicator()
                        : _buildRegBtn(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        children: [
                          Text(
                            " Already have an account?" + ' ',
                            style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                            },
                            child: Text(
                              " Log In" + ' ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildRegBtn() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (_registerFormKey.currentState!.validate()) {
                _registerFormKey.currentState?.save();

                User? user = (await FireAuth.registerUsingEmailPassword(
                  name: _nameTextController.text,
                  email: _emailTextController.text,
                  password: _passwordTextController.text,
                ));

                setState(() {
                  _isProcessing = false;
                });

                if (user != null) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(user),
                    ),
                    ModalRoute.withName('/'),
                  );
                }
              }
            },
            child: Text(
              'Sign up',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
