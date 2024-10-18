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

  final _filterController = TextEditingController();
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
              DropdownMenu(controller: _filterController,
                  dropdownMenuEntries: account_provider.acc_categories.map((String value) {
                    return DropdownMenuEntry(
                    value: value,
                    label: value
                    );
                  }).toList(),
                  onSelected: (String? value) {
                    if(value != null) {
                      account_provider.setFilter(value);
                    }
                  },),
              Column(
                children: account_provider.generateHistoryList_filtered(account_provider.history_filter),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
