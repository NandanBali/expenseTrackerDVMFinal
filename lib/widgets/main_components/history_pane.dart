import 'package:expense_tracker_dvm/widgets/history_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker_dvm/globals.dart' as globals;
import 'package:expense_tracker_dvm/models/providers/account_provider.dart';

class HistoryPane extends StatefulWidget {
  const HistoryPane({super.key});

  @override
  State<HistoryPane> createState() => _HistoryPaneState();
}

class _HistoryPaneState extends State<HistoryPane> {
  @override
  Widget build(BuildContext context) {
    final account_provider = Provider.of<AccountProvider>(context);
    return Consumer(
        builder: (context, value, child) => Container(
              padding: globals.stdPadding,
              margin: globals.stdPadding,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: globals.color2.withOpacity(0.2),
                    offset: const Offset(6.0, 6.0),
                    blurRadius: 16.0,
                  ),
                ],
                color: globals.color1,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(width: double.infinity),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Recent Transactions",
                          style: GoogleFonts.ibmPlexMono(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
                          },
                          child: const Row(
                            children: <Widget>[
                              Icon(Icons.info_outline),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Column(
                    children: account_provider.generateHistoryList_temp(),
                  )
                ],
              ),
            ));
  }
}
