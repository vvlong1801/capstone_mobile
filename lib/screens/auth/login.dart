import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/auth/auth_controller.dart';
import 'package:user_side_final_project/utils/validate.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> onSubmit() async {
    try {
      setLoading(true);
      await ref
          .read(authController.notifier)
          .login(emailController.text, passwordController.text);
      GoRouter.of(context).goNamed(exploreRoute);
      setLoading(false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ref.read(authController.notifier).errorMessage)));
      setLoading(false);
    }
  }

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
                      const Center(
                          child: Text(
                        "LOGIN",
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
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration:
                                  const InputDecoration(labelText: "Email"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter email";
                                }
                                if (!Validator.isEmailValid(value)) {
                                  return "Email invalid";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Center(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.deepPurpleAccent),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await onSubmit();
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepPurple)),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                          )),
                      const SizedBox(
                        height: 14,
                      ),
                      Center(
                        child: RichText(
                            text: const TextSpan(
                                text: "don't have an account? ",
                                style: TextStyle(color: Colors.black87),
                                children: [
                              TextSpan(
                                  text: "Signup",
                                  style:
                                      TextStyle(color: Colors.deepPurpleAccent))
                            ])),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(children: [
                        Expanded(
                          child: TextButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue.shade600),
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(vertical: 4))),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.facebook_rounded,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Login with Facebook",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ]),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(children: [
                        Expanded(
                          child: TextButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(vertical: 4))),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.home,
                                color: Colors.black87,
                              ),
                              label: const Text(
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
