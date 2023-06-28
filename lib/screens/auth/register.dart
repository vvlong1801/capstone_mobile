import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              decoration:
                                  const InputDecoration(labelText: "Name"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter name";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration:
                                  const InputDecoration(labelText: "Email"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: passwordController,
                              enableSuggestions: false,
                              autocorrect: false,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(labelText: "Password"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter password";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: passwordConfirmationController,
                              enableSuggestions: false,
                              autocorrect: false,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: "Confirm Password"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Confirm password";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepPurple)),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                      SizedBox(
                        height: 14,
                      ),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                text: "don't have an account? ",
                                style: TextStyle(color: Colors.black87),
                                children: [
                              TextSpan(
                                  text: "Login",
                                  style:
                                      TextStyle(color: Colors.deepPurpleAccent))
                            ])),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Divider(),
                      SizedBox(
                        height: 4,
                      ),
                      Row(children: [
                        Expanded(
                          child: TextButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue.shade600),
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(vertical: 4))),
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook_rounded,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Login with Facebook",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ]),
                      SizedBox(
                        height: 4,
                      ),
                      Row(children: [
                        Expanded(
                          child: TextButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(vertical: 4))),
                              onPressed: () {},
                              icon: Icon(
                                Icons.home,
                                color: Colors.black87,
                              ),
                              label: Text(
                                "Login with Google",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
