import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raion_battlepass_dummy/Bloc/Auth/login_bloc.dart';

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
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoginSuccess) {
            final profileData = state.profileData;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama: ${profileData['name']}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Email: ${profileData['email']}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Role: ${profileData['role']}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  if (profileData['avatar'] != null)
                    Image.network(profileData['avatar']),
                ],
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