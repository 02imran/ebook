import 'package:ebook/authentication/firebase_register.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:ebook/utils/fire_auth.dart';
import 'package:ebook/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen(user)),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('e-book'),
        ),
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildLoginForm();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Wrap(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/ebooklogo.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Login to " + ' ',
                    style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                TextFormField(
                  controller: _emailTextController,
                  focusNode: _focusEmail,
                  validator: (value) => Validator.validateEmail(
                    email: value!,
                  ),
                  onSaved: (value) {
                    print('email : ' + value.toString());
                  },
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
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _passwordTextController,
                  focusNode: _focusPassword,
                  obscureText: true,
                  validator: (value) => Validator.validatePassword(
                    password: value!,
                  ),
                  onSaved: (value) {
                    print('value pass :' + value.toString());
                  },
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
                SizedBox(height: 24.0),
                _createLoginBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _createLoginBtn() {
    return _isProcessing
        ? CircularProgressIndicator()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    _focusEmail.unfocus();
                    _focusPassword.unfocus();

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();

                      setState(() {
                        _isProcessing = true;
                      });

                      User? user = (await FireAuth.signInUsingEmailPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      ));

                      setState(() {
                        _isProcessing = false;
                      });

                      // ignore: unnecessary_null_comparison
                      if (user != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(user),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 24.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
  }
}
