import 'package:bloc_quiz/presentation/dashboard/result/results_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../Profile/profile.dart';
import '../auth/sign_in/sign_in.dart';
import 'categories/categories_screen.dart';

class Dashboard extends StatelessWidget {
  final User currentUser;
  const Dashboard(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const Text('BLoC Quiz', style: TextStyle(
                      fontSize: 24,
                    ),),
                    backgroundColor: Colors.green,
                    bottom: const TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.home)),
                        Tab(icon: Icon(Icons.domain_verification)),
                      ],
                    ),
                  ),
                  drawer: Drawer(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          UserAccountsDrawerHeader(
                            decoration: const BoxDecoration(color: Colors.green),
                            accountName: Text(
                              '${currentUser.displayName}',
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            accountEmail: Text(
                              '${currentUser.email}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            currentAccountPicture: currentUser.photoURL != null
                                ? Image.network("${currentUser.photoURL}")
                                : const FlutterLogo(),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.contact_page,
                            ),
                            title: const Text('My Profile', style: TextStyle(
                              fontSize: 20,
                            ),),
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) {
                                  return Profile();
                                },
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return FadeTransition(
                                      opacity: animation, child: child);
                                },
                              ));
                            },
                          ),
                          const AboutListTile(
                            // <-- SEE HERE
                            icon: Icon(
                              Icons.info,
                            ),
                            child: Text('About app', style: TextStyle(
                              fontSize: 20,
                            ),),
                            applicationIcon: Icon(
                              Icons.task_alt,
                            ),
                            applicationName: 'BLoC Quiz',
                            applicationVersion: '1.0.0',
                            applicationLegalese: 'Pranshu Malhotra',
                            aboutBoxChildren: [
                              ///Content goes here...
                            ],
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.logout_rounded,
                            ),
                            title: const Text('Log out', style: TextStyle(
                              fontSize: 20,
                            ),),
                            onTap: () {
                              context.read<AuthBloc>().add(SignOutRequested());
                            },
                          ),
                        ],
                      )),
                  body: BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is UnAuthenticated) {
                        // Navigate to the sign in screen when the user Signs Out
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => SignIn()),
                              (route) => false,
                        );
                      }
                    },
                    child: TabBarView(
                      children: [
                        const Categories(),
                        Results(),
                      ],
                    ),
                  ),
                ));
  }
}
