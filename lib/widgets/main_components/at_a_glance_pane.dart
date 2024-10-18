import 'package:expense_tracker_dvm/widgets/reused_components/glance_card.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_dvm/models/providers/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_dvm/globals.dart' as globals;

class AtAGlancePane extends StatefulWidget {
  const AtAGlancePane({super.key});

  @override
  State<AtAGlancePane> createState() => _AtAGlancePaneState();
}

class _AtAGlancePaneState extends State<AtAGlancePane> {
  String _getMonth() {
    String month = "";
    switch (DateTime.now().month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      default:
        month = "December";
        break;
    }
    return month;
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: globals.color2.withOpacity(0.2),
          offset: const Offset(6.0, 6.0),
          blurRadius: 16.0,
        ),
      ],
      color: globals.color1,
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final account_provider = Provider.of<AccountProvider>(context);
    return Consumer(
        builder: (context, value, child) => Container(
              decoration: _boxDecoration(),
              padding: globals.stdPadding,
              margin: globals.stdPadding,
              child: Column(
                children: <Widget>[
                  GlanceCard(
                      "₹${account_provider.acc_month_in.toString()}",
                      "Income this ${_getMonth()}",
                      <Color>[Colors.lightGreenAccent, Colors.green]),
                  SizedBox(height: 8.0),
                  GlanceCard(
                      "₹${account_provider.acc_month_ex.toString()}",
                      "Expenses this ${_getMonth()}",
                      <Color>[Colors.pinkAccent, Colors.red]),
                  SizedBox(height: 8.0),
                  GlanceCard("₹${account_provider.acc_balance.toString()}",
                      "Net Balance", <Color>[Colors.lightBlueAccent, Colors.blue]),
                ],
              ),
            ));
  }
}
