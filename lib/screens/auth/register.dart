import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/auth/auth_controller.dart';
import 'package:user_side_final_project/utils/validate.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  bool isLoading = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> onSubmit() async {
    try {
      setLoading(true);
      debugPrint(_nameController.text);
      await ref.read(authController.notifier).register(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          passwordConfirmation: _passwordConfirmationController.text);

      GoRouter.of(context).pushNamed(verifyRoute);
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: Text(
                      "Create your Account",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            decoration:
                                const InputDecoration(labelText: "Name"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
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
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _passwordController,
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
                            controller: _passwordConfirmationController,
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: "Confirm Password"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Confirm password";
                              }
                              if (value != _passwordController.text) {
                                return "confirm password not match";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32,
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
