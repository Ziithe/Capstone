import 'package:cloud_firestore/cloud_firestore.dart';

class groupTransaction {
  String? amount;
  String? comment;
  String? details;
  String? senderEmail;
  String? senderName;
  Timestamp? sendDate;
  String? uid;

  groupTransaction();

  Map<String, dynamic> toJson() => {
        'details': details,
        'comment': comment,
        'sendDate': sendDate,
        'senderEmail': senderEmail,
        'senderName': senderName,
        'uid': uid,
        'amount': amount,
      };

  groupTransaction.fromSnapshot(snapshot)
      : details = snapshot.data()['details'],
        comment = snapshot.data()['comment'],
        sendDate = snapshot.data()['sendDate'],
        senderEmail = snapshot.data()['senderEmail'],
        senderName = snapshot.data()['senderName'],
        amount = snapshot.data()['amount'],
        uid = snapshot.data()['uid'];
}
