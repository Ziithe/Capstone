import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String? details;
  String? comment;
  Timestamp? date;

  Activity();

  Map<String, dynamic> toJson() =>
      {'details': details, 'comment': comment, 'date': date};

  Activity.fromSnapshot(snapshot)
      : details = snapshot.data()['details'],
        comment = snapshot.data()['comment'],
        date = snapshot.data()['date'];
}
