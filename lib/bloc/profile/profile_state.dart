import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProfileState extends Equatable {
}

class Loading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class Success extends ProfileState {
  final User user;

  Success(this.user);

  @override
  List<Object?> get props => [user.photoURL];
}

class ProfileUpdateState extends Success {
  final String url;

  ProfileUpdateState(this.url, user) : super(user);

  @override
  List<Object?> get props => [url];
}

class Error extends ProfileState {
  final String error;

  Error(this.error);
  @override
  List<Object?> get props => [error];
}
