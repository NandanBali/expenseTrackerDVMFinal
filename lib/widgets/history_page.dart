import 'package:expense_tracker_dvm/models/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_dvm/globals.dart' as globals;
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final account_provider = Provider.of<AccountProvider>(context);
    account_provider.addWidgets(null);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Payments'),
      ),
      body: Center(
        child: Padding(
          padding: globals.stdPadding,
          child: Consumer(builder: (context, value, child) => Column(
            children: <Widget>[
              ElevatedButton(onPressed: () {
                account_provider.addWidgets("Money Transfer");
              }, child: const Text("Money Transfer")),
              Column(
                children: account_provider.acct_history_cards,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
