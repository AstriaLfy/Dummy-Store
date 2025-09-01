import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raion_battlepass_dummy/models/users.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {

    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      final url = Uri.parse("https://api.escuelajs.co/api/v1/auth/login");

      try{
        final response = await http.post(url,headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": event.gmail,
          "password": event.password,
        }),
        );
        if (response.statusCode == 201){
          final responseBody = jsonDecode(response.body);
          final token = responseBody['access_token'];
          print("Login Success123");
          print("$token");

          
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("jwt_token", token);

          print("Debug Load Profile");
          add(LoadProfile());
        }

        else{
          print("password or username wrong");
          emit(LoginFailure("error"));
        }

      }catch(e){
        print("Error $e");
        emit(LoginFailure("error"));
      }
    });

    on<LoadProfile>((event, emit) async {
      emit(LoginLoading());
      print("Load Triggered");

        try{
          final pref = await SharedPreferences.getInstance();
          final token = pref.getString("jwt_token");
          if(token == null){
            emit(UnAuth());
            return;
          }

          final response = await http.get(
            Uri.parse("https://api.escuelajs.co/api/v1/auth/profile"),
              headers: {'Authorization' : 'Bearer $token'}
          );

          if (response.statusCode == 200) {
            //final profile = jsonDecode(response.body);
            final profile = productFromJson(response.body);
            emit(LoginSuccess(profile));
            print("Login Succeed");
            print(profile);
          } else emit(LoginFailure("error"));
        }
        catch(e){
          print("TOKEN ERROR $e");
        }
    });

  }
}

