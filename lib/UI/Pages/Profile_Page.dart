import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raion_battlepass_dummy/Bloc/Auth/login_bloc.dart';
import 'package:raion_battlepass_dummy/UI/Pages/Home_Page.dart';
import 'package:raion_battlepass_dummy/UI/Pages/Login_Page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoginSuccess) {
            final profileData = state.profileData;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Is it you?"),
                    SizedBox(height: 100,),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey,
                      child: Image.network(profileData.avatar, width: 100, height: 100,),
                    ),
                    Text(profileData.name),
                    Text(profileData.email),
                    Text(profileData.password),
                    Text(profileData.role),

                    SizedBox(height: 100,),

                    ElevatedButton(onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);},
                        child: Text("Yes it's me")),

                    ElevatedButton(onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);},
                        child: Text("No its not me")),

                  ],
                ),
              ),
            );
          }
          if (state is LoginFailure) {
            return const Center(child: Text("Failed to load profile."));
          }
          return const Center(child: Text("Ready to load profile..."));
        },
      ),
    );
  }
}