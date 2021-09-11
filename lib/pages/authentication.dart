import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import '../database.dart';
import 'package:ecolation/account.dart' show Account;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  String? get email => null;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  void sendAccount(String email, String password) {
    var account = Account(email, password);
    account.setId(saveAccount(account));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
            height: 50,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'images/logo.png',
                  height: 125,
                  width: 125,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Ecolation",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                      color: Colors.grey[800],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Create your Account',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Email',
                          contentPadding: EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!emailController.text.contains('@')) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        controller: pwController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: 'Password',
                          contentPadding: EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Use 6 characters or more for your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Confirm Password',
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (pwController.text != value) {
                            return 'The passwords didn\'t match. Try again.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade700),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              final hashedPw = Crypt.sha256(pwController.text,
                                  rounds: 100, salt: 'abcdefghijklmnop');
                              sendAccount(emailController.text.toLowerCase(),
                                  hashedPw.toString());
                              Navigator.pushNamed(context, '/home');
                            }
                          },
                          child: const Text('Sign up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                        ),
                      ),
                      const SizedBox(height: 180),
                      Text.rich(TextSpan(
                        text: 'Already have an account? ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                  color: Colors.blue.shade600,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushNamed(context, '/login');
                                })
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SecondScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final pwController = TextEditingController();

  String? get email => null;

  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    pwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
            height: 50,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'images/logo.png',
                  height: 125,
                  width: 125,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Ecolation",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                      color: Colors.grey[800],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Login to your Account',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Email',
                            contentPadding: EdgeInsets.all(16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!emailController.text.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          }),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: pwController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Password',
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade700),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              final hashedPwLogin = Crypt.sha256(
                                  pwController.text,
                                  rounds: 100,
                                  salt: 'abcdefghijklmnop');
                              Future<bool> loginChecker() async {
                                var verified = await checkPw(
                                    emailController.text.toLowerCase(),
                                    hashedPwLogin.toString());
                                if (verified) {
                                  Navigator.pushNamed(context, '/home');
                                }
                                return verified;
                              }

                              loginChecker();
                            }
                          },
                          child: const Text('Sign in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                        ),
                      ),
                      const SizedBox(height: 180),
                      Text.rich(TextSpan(
                        text: 'Don\'t have an account?   ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                  color: Colors.blue.shade600,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushNamed(context, '/register');
                                })
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
