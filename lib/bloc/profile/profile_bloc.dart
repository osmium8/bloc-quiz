import 'package:bloc_quiz/bloc/profile/profile_event.dart';
import 'package:bloc_quiz/bloc/profile/profile_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/repositories/storage_repo.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final StorageRepo repository;

  ProfileBloc({required this.repository}) : super(Loading()) {
    on<DataRequested>((event, emit) async {
      emit(Loading());
      try {
        bool result = await checkConnectivity();
        if (result) {
          emit(Success(FirebaseAuth.instance.currentUser!));
        } else {
          emit(Error("No internet connection. Try again later."));
        }
      } catch (e) {
        emit(Error(e.toString()));
      }
    });

    on<ProfileImageUpdateEvent>((event, emit) async {
      emit(Loading());
      try {
        bool result = await checkConnectivity();
        if (result) {
          var downloadUrl = await repository.uploadUsersProfileFile(event.file);
          debugPrint('profile_bloc: $downloadUrl');
          emit(ProfileUpdateState(downloadUrl!, FirebaseAuth.instance.currentUser!));
        } else {
          emit(Error("No internet connection. Try again later."));
        }
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }

  Future<bool> checkConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

}