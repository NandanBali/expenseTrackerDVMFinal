// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:expense_tracker_dvm/models/app_models/payment.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker_dvm/globals.dart' as globals;

// ignore: must_be_immutable
class HistoryCard extends StatelessWidget {
  final Payment payment;
  List<Color> gradientColors = [];

  HistoryCard(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    if (payment.amount > 0) {
      gradientColors = [Colors.lime, Colors.green];
    } else {
      gradientColors = [Colors.pinkAccent, Colors.red];
    }
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(16.0),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: globals.stdPadding,
            child: Column(
              children: <Widget>[
                Text(
                  "₹${(payment.amount.abs()).toString()}",
                  style: GoogleFonts.ibmPlexSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 32.0,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "On ${payment.payment_time.day}/${payment.payment_time.month}/${payment.payment_time.year}",
                    style: GoogleFonts.ibmPlexMono(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "for ${payment.category}",
                    style: GoogleFonts.ibmPlexMono(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              //TODO: Beautify description
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.0),
                    ),
                  ),
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Amount: ${payment.amount.toString()}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "Time: ${payment.payment_time.hour}:${payment.payment_time.minute} on ${payment.payment_time.day}/${payment.payment_time.month}/${payment.payment_time.year}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "Description: ${payment.description}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "Category: ${payment.category}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.info_outline,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
