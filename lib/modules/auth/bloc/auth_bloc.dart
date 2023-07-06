import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:land_wiki/modules/api/api.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<GoogleAuthenticate>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = AppApi.getCurrentUser();
        if (user != null) {
          emit(AuthLoaded(user: user));
        } else {
          final result = await AppApi().signInWithGoogle();
          emit(AuthLoaded(user: result.user!));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<GoToHome>((event, emit) {
      emit(AuthInitial());
    });
  }
}
