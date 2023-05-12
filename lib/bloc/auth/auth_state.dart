part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

// When the user presses the signin or signup button the state is changed to loading first and then to Authenticated.
class Loading extends AuthState {
  @override
  List<Object?> get props => [0];
}

class UserDataChange extends AuthState {
  @override
  List<Object?> get props => [1];
}

// When the user is authenticated the state is changed to Authenticated.
class Authenticated extends AuthState {
  final User currentUser;
  Authenticated(this.currentUser);
  @override
  List<Object?> get props => [2];
}

// This is the initial state of the bloc. When the user is not authenticated the state is changed to Unauthenticated.
class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [3];
}

// If any error occurs the state is changed to AuthError.
class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
