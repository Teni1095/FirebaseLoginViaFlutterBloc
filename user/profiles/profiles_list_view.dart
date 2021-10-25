import 'package:entre_to_buss/requests/follow_requests_bloc/follow_requests_bloc.dart';
import 'package:entre_to_buss/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTile extends StatefulWidget {
  final Profile profile;

  const ProfileTile({Key? key, required this.profile}) : super(key: key);

  @override
  _ProfileTileState createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.profile.userId),
        ElevatedButton(
            onPressed: () => BlocProvider.of<FollowRequestsBloc>(context).add(SendRequest(widget.profile)),
            child: const Text("Send request"))
      ],
    );
  }
}

class ProfilesList extends StatefulWidget {
  final List<Profile> profiles;

  const ProfilesList({Key? key, required this.profiles}) : super(key: key);

  @override
  _ProfilesListState createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.profiles.length,
        itemBuilder: (context, index) {
          return ListTile(title: ProfileTile(profile: widget.profiles[index]));
        });
  }
}
