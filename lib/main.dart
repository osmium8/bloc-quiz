import 'package:bloc_quiz/bloc/auth/auth_bloc.dart';
import 'package:bloc_quiz/data/repositories/auth_repository.dart';
import 'package:bloc_quiz/presentation/Dashboard/dashboard.dart';
import 'package:bloc_quiz/presentation/auth/sign_in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: StreamBuilder<User?>(
            // we will user userChanges() instead to authStateChanges() to rebuild drawer with latest profile image
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in.
                if (snapshot.hasData) {
                  return Dashboard(snapshot.data!);
                }
                // Otherwise, they're not signed in
                return SignIn();
              }),
        ),
      ),
    );
  }
}
