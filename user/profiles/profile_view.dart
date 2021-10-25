import 'package:entre_to_buss/user/profiles/profile_bloc/profile_bloc.dart';
import 'package:entre_to_buss/user/profiles/profiles_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfProfilesView extends StatefulWidget {
  const ListOfProfilesView({Key? key}) : super(key: key);

  @override
  _ListOfProfilesViewState createState() => _ListOfProfilesViewState();
}

class _ListOfProfilesViewState extends State<ListOfProfilesView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if(state is ProfilesReceived){
          return ProfilesList(profiles: state.profiles);
        }
        else{
          return Container();
        }
      });
  }
}
