import 'package:flutter/material.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/data/activity_data.dart';

class activityCard extends StatelessWidget {
  final ActivityModel activity;
  const activityCard({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.send_to_mobile_rounded,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      activity.activityName,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      Text(activity.date + ", ",
                          style: TextStyle(color: textSecondary, fontSize: 13)),
                      Text(activity.time,
                          style: TextStyle(color: textSecondary, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(activity.amount,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Text(
                        activity.status,
                        style: TextStyle(color: successColor, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
