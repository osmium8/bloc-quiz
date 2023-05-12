import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class DataRequested extends ProfileEvent {
}
class ProfileImageUpdateEvent extends ProfileEvent {
  final File file;
  ProfileImageUpdateEvent(this.file);
}
