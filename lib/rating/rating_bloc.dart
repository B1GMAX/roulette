import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roulette/model/user_model.dart';
import 'package:rxdart/rxdart.dart';

class RatingBloc {
  RatingBloc() {
    if (FirebaseAuth.instance.currentUser != null) {
      _readUsers();
    }
  }

  final _userModelController = BehaviorSubject<UserModel>();

  final _usersModelListController = BehaviorSubject<List<UserModel>>();

  Stream<UserModel> get userModelStream => _userModelController.stream;

  Stream<List<UserModel>> get usersModelListStream =>
      _usersModelListController.stream;

  void _readUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final userFromJson = UserModel.fromJson(doc.data());
              if (doc.id == FirebaseAuth.instance.currentUser!.uid) {
                _userModelController.add(userFromJson);
              }
              return userFromJson;
            }).toList())
        .listen((event) {
      final List<UserModel> usersList = event;
      usersList.sort((a, b) => b.value.compareTo(a.value));
      _usersModelListController.add(usersList);
    });
  }

  void dispose() {
    _userModelController.close();
    _usersModelListController.close();
  }
}
