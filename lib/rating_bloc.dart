import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roulette/user_model.dart';
import 'package:rxdart/rxdart.dart';

class RatingBloc {
  RatingBloc() {
    if (FirebaseAuth.instance.currentUser != null) {
      _readUser();
      _readUsers();
    }
  }

  final _userModelController = BehaviorSubject<UserModel>();

  final _usersModelListController = BehaviorSubject<List<UserModel>>();

  Stream<UserModel> get userModelStream => _userModelController.stream;

  Stream<List<UserModel>> get usersModelListStream =>
      _usersModelListController.stream;

  void _readUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _userModelController.add(
          UserModel(
              name: documentSnapshot['name'],
              value: documentSnapshot['value'],
              winRate: documentSnapshot['winRate']),
        );
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void _readUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList())
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
