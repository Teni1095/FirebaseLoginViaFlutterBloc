part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class SearchingForProfiles extends ProfileState {
  final String searchString;
  const SearchingForProfiles(this.searchString);
  @override
  List<Object> get props => [searchString];
}

class ProfilesReceived extends ProfileState {
  final String searchString;
  final List<Profile> profiles;
  const ProfilesReceived(this.searchString, this.profiles);
  @override
  List<Object> get props => [searchString];
}
