import 'package:flutter/material.dart';
import 'package:mgulu_savings/Screens/Pages/recentActivity.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/constants/size.dart';

class activityCard extends StatelessWidget {
  final Activity activity;
  const activityCard({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.timer_rounded,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activity.details.toString(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: screenWidth(context) * 0.25,
                      ),
                      Text(activity.comment.toString(),
                          style: TextStyle(fontSize: 13, color: successColor)),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight(context) * 0.01,
                  ),
                  Row(
                    children: [
                      Text((activity.date!.toDate()).toString(),
                          style: TextStyle(color: textSecondary, fontSize: 13)),
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
