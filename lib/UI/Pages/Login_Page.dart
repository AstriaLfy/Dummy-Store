import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:raion_battlepass_dummy/Bloc/Auth/login_bloc.dart';


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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
           //Text("RAION BATTLEPASS 2026", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
            Text("by: Mohammad Rozan Hanan"),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 5),
                  blurRadius: 20,
                  spreadRadius: 2
                )]
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Text("Login"),
                      Text("Register"),
                    ],),
                    SizedBox(height: 20,),


                    TextField(
                      controller: usnController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        )
                      ),
                    ),
                    SizedBox(height: 20,),


                    TextField(
                      controller: pwController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                      ),
                    ),
                    SizedBox(height: 50,),


                    ElevatedButton(onPressed: (){
                      loginBloc.add(LoginSubmitted(usnController.text, pwController.text));
                    }, child: Text("Login"))
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }


}


