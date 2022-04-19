import 'package:cloud_firestore/cloud_firestore.dart';

class loanRequests {
  String? amount;
  String? loanDueDate;
  String? requestEmail;
  String? requestFrom;
  String? requestId;
  String? status;
  Timestamp? requestDate;

  loanRequests();

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "loanDueDate": loanDueDate,
        "requestEmail": requestEmail,
        "requestFrom": requestFrom,
        "requestId": requestId,
        "status": status,
        "requestDate": requestDate,
      };

  loanRequests.fromSnapshot(snapshot)
      : amount = snapshot.data()['amount'],
        loanDueDate = snapshot.data()['loanDueDate'],
        requestEmail = snapshot.data()['requestEmail'],
        requestFrom = snapshot.data()['requestFrom'],
        requestId = snapshot.data()['requestId'],
        status = snapshot.data()['status'],
        requestDate = snapshot.data()['requestDate'];
}
