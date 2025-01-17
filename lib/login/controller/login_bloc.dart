import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_skripsi/login/models/login_body.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import '../models/login_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SaveLoginSession>(_onSaveLoginSession);
    on<GetLoginData>(_onGetLoginData);
    on<Logout>(_onLogout);
  }
  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      print("mulai");
      final response = await http.post(
        Uri.parse('$apiUrl/hris/v1/employee/login'),
        body: LoginBody(
          username: event.username,
          password: event.password,
        ).toJson(),
      );
      print("selesai");
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("${response.statusCode},${response.body}");
      if (response.statusCode == 200) {
        emit(
          LoginSuccess(
            loginModel: LoginModel.fromJson(data),
          ),
        );
        add(SaveLoginSession(loginModel: LoginModel.fromJson(data)));
      } else {
        emit(LoginFailure());
      }
    } catch (e) {
      emit(LoginFailure());
    }
  }

  Future<void> _onSaveLoginSession(
    SaveLoginSession event,
    Emitter<LoginState> emit,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("login", jsonEncode(event.loginModel));
  }

  void _onGetLoginData(
    GetLoginData event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("login");
    if (data != null) {
      emit(
        LoginSuccess(
          loginModel: LoginModel.fromJson(jsonDecode(data)),
        ),
      );
    } else {
      emit(LoginFailure());
    }
  }

  void _onLogout(
    Logout event,
    Emitter<LoginState> emit,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("login");
    emit(LoginInitial());
  }
}
