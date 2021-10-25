import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'user_repository.g.dart';

@JsonSerializable()
class EBUser {
  String id;
  String? name;
  String? email;

  EBUser(this.id, this.email, this.name);

  factory EBUser.fromJson(Map<String, dynamic> json) => _$EBUserFromJson(json);

  Map<String, dynamic> toJson() => _$EBUserToJson(this);
}

@JsonSerializable()
class Profile {
  String id;
  String userId;

  Profile(this.id, this.userId);

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

class UserRepository {
  UserRepository();

  late EBUser _currentUser;

  EBUser get currentUser => _currentUser;
  var db = FirebaseFirestore.instance.collection("users");

  void _setCurrentUser(EBUser user) {
    _currentUser = user;
  }

  Future<List<EBUser>> getUsersFromID(List<String> ids) async {
    Query<Map<String, dynamic>> query = db;
    List<EBUser> ebUsers = [];
    for (var id in ids) {
      query = query.where("id", isEqualTo: id);
    }

    var docs = await query.get();
    for (var json in docs.docs) {
      ebUsers.add(EBUser.fromJson(json.data()));
    }
    return ebUsers;
  }

  Future<EBUser> addUser(UserCredential userCred) async {
    var path = db.doc();
    EBUser user =
        EBUser(path.id, userCred.user!.email, userCred.user!.displayName);
    await path.set(user.toJson());
    var profilePath = path.collection("profile").doc();
    Profile profile = Profile(profilePath.id, user.id);
    await profilePath.set(profile.toJson());
    _setCurrentUser(user);
    return user;
  }

  Future<EBUser?> getUser(String email) async {
    var doc = await db.where("email", isEqualTo: email).get();
    if (doc.docs.isNotEmpty) {
      return EBUser.fromJson(doc.docs.first.data());
    } else {
      return null;
    }
  }

  Future<EBUser?> getUserFromId(String id) async {
    var doc = await db.where("id", isEqualTo: id).get();
    if (doc.docs.isNotEmpty) {
      return EBUser.fromJson(doc.docs.first.data());
    } else {
      return null;
    }
  }

  Future<EBUser> signUpWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return await addUser(userCredential);
  }

  Future<EBUser> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    EBUser? user = await getUser(userCredential.user!.email!);
    if(user!=null) {
      _setCurrentUser(user);
      return user;
    }
    else{
      throw ErrorWidget.withDetails(message: "User not found");
    }
  }

  Future<EBUser> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    EBUser? user = await getUser(googleUser.email);
    if (user == null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return await addUser(userCredential);
    } else {
      _setCurrentUser(user);
      return user;
    }
  }

  Future<List<Profile>> getProfilesFromSearch(String searchString) async {
    var docs =
        await db.where("email", isGreaterThanOrEqualTo: searchString).get();
    List<Profile> profiles = [];
    for (var profile in docs.docs) {
      profiles.add(Profile.fromJson(profile.data()));
    }
    return profiles;
  }
}
