import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:raion_battlepass_dummy/Bloc/Auth/AuthRepository.dart';
import 'package:http/http.dart' as http;

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
          print("Login Success");
          print("");

        }
        else{
          print("password or username wrong");
        }

      }catch(e){
        print("Error $e");
      }
      }

    );
  }
}
