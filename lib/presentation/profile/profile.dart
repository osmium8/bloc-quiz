import 'dart:io';
import 'package:bloc_quiz/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../../data/repositories/storage_repo.dart';

class Profile extends StatelessWidget {
  static final String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(repository: StorageRepo())..add(DataRequested()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Profile'),
            backgroundColor: Colors.green,
          ),
          body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdateState) {
                BlocProvider.of<AuthBloc>(context)
                    .add(ProfileImageChangeRequested(state.url));
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
              if (state is Success) {
                // will also execute for child classes: ProfileUpdateState
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.user.photoURL != null
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child:
                                  Image.network("${state.user.photoURL}", width: 100),
                              onPressed: () {},
                            )
                          : Container(),
                      const SizedBox(height: 16),
                      state.user.displayName != null
                          ? Text("${state.user.displayName}",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                          : Container(),
                      const SizedBox(height: 16),
                      Text(
                        '${state.user.email}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        child: const Text('Sign Out'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () {
                          // Signing out the user
                          context.read<AuthBloc>().add(SignOutRequested());
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Update Profile Image'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          showUpdateProfileImageAlertDialog(context);
                        },
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Loading...', style: TextStyle(fontSize: 40),));
            }),
          ),
        ));
  }

  showUpdateProfileImageAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cameraButton = ElevatedButton(
      child: const Text("Camera"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      onPressed: () async {
        XFile? imageFile = await ImagePicker().pickImage(
            source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
        debugPrint('path: ${imageFile!.path}');
        BlocProvider.of<ProfileBloc>(context)
            .add(ProfileImageUpdateEvent(File(imageFile.path)));
        Navigator.of(context).pop();
      },
    );
    Widget galleryButton = ElevatedButton(
      child: const Text("Gallery"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      onPressed: () async {
        XFile? imageFile = await ImagePicker().pickImage(
            source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
        debugPrint('path: ${imageFile!.path}');
        BlocProvider.of<ProfileBloc>(context)
            .add(ProfileImageUpdateEvent(File(imageFile.path)));
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Choose source:"),
      actions: [
        cameraButton,
        galleryButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
