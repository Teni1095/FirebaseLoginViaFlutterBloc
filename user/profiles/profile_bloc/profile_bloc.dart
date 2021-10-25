import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:entre_to_buss/user/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final UserRepository _userRepository;

  ProfileBloc(this._userRepository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfilesFromSearch) {
        emit(SearchingForProfiles(event.searchString));
        var profiles = await _userRepository.getProfilesFromSearch(
            event.searchString);
        emit(ProfilesReceived(event.searchString, profiles));
      }
    });
  }
}
