part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfilesFromSearch extends ProfileEvent{

  final String searchString;
  const GetProfilesFromSearch(this.searchString);
  @override
  List<Object?> get props => [searchString];

}
