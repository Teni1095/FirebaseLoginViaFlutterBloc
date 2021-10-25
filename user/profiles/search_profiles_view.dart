import 'package:entre_to_buss/requests/follow_requests_bloc/follow_requests_bloc.dart';
import 'package:entre_to_buss/user/profiles/profile_bloc/profile_bloc.dart';
import 'package:entre_to_buss/user/profiles/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchProfiles extends SearchDelegate {
  ProfileBloc profileBloc;
  FollowRequestsBloc followRequestsBloc;
  // FollowRequestsBloc followRequestBloc;

  SearchProfiles(this.profileBloc, this.followRequestsBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    profileBloc.add(GetProfilesFromSearch(query));
    return BlocProvider.value(
      value: profileBloc,
      child: BlocProvider.value(
          value: followRequestsBloc,
          child: const ListOfProfilesView()),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }


}
