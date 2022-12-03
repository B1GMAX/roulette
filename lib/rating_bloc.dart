import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roulette/user_model.dart';

class RatingBloc {
  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
}
