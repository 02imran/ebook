import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    firebaseStore.collection('eBooksUserProfile');

class Database {
  static String? userUid;

  /// Added User Register
  static Future<void> addUserRegister(
      {required String userName,
      required String userMail,
      required String userPayStatus}) async {
    DocumentReference documentReferencer = _mainCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "userId": userUid,
      "Name": userName,
      "Mail": userMail,
      "PaymentStatus": userPayStatus,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("User Register added to the database"))
        .catchError((e) => print(e));
  }

  /// User Update
  ///  User Delete

  ///  User Status Check
  /* static Stream<QuerySnapshot> readPaymentStatusCheck() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).

    return notesItemCollection.snapshots();
  }*/
}
