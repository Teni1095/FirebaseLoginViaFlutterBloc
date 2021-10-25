import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_to_buss/user/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';

part 'user_state.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {}
}
