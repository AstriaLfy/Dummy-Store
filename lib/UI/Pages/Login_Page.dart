import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:raion_battlepass_dummy/Bloc/Auth/login_bloc.dart';
import 'Profile_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usnController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            print("Move to Profile Page");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usn or Pw Error")),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            print("Loading");
            return const Center(child: CircularProgressIndicator());
          }
          // UI form login
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                //Text("RAION BATTLEPASS 2026", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
                const Text("by: Mohammad Rozan Hanan"),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text("Login"),
                            Text("Register"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: usnController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: pwController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            if(usnController.text == "" && pwController.text == ""){
                              print("usn and pw is null");
                            } else if(pwController.text.length < 8 ){
                              print("Password >= 8");
                            }
                            else {print("login acc");
                            loginBloc.add(LoginSubmitted(usnController.text, pwController.text));
                              }
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}