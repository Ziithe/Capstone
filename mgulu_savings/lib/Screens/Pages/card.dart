import 'dart:ui';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/data/card_data.dart';

import '../../constants/size.dart';

class MyCard extends StatelessWidget {
  final CardModel card;
  const MyCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(right: 10),
        height: screenHeight(context) * 0.08,
        width: screenWidth(context) * 0.8,
        decoration: BoxDecoration(
          color: primaryLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                card.groupName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              card.groupType,
                              style:
                                  TextStyle(color: textSecondary, fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth(context) * 0.3),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Members",
                              style:
                                  TextStyle(color: textSecondary, fontSize: 11),
                            ),
                            Text(card.memberCount),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.groupGoal,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(card.groupCode),
                        IconButton(
                            onPressed: () async {
                              await FlutterClipboard.copy(card.groupCode);
                            },
                            icon: Icon(Icons.copy_rounded))
                      ],
                    ),
                  ])
            ]));
  }
}
