import 'package:expense_tracker_dvm/models/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_dvm/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_dvm/models/app_models/payment.dart';
import 'dart:math';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  // controllers
  final TextEditingController _controllerAmount = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _controllerCategory = TextEditingController();

  // helper functions
  void _dispose() {
    _controllerAmount.clear();
    _controllerDescription.clear();
    _paymentTypeController.clear();
    _controllerCategory.clear();
  }

  Payment _generatePayment() {
    double amount = double.parse(_controllerAmount.text.replaceAll(' ', '')).abs();
    if (_paymentTypeController.text == "Debit") {
      amount *= -1;
    }
    var rng = Random();
    return Payment(
        id: rng.nextInt(1000000),
        amount: amount,
        description: _controllerDescription.text.isEmpty
            ? ''
            : _controllerDescription.text,
        category: _controllerCategory.text,
        payment_time: DateTime.now());
  }

  void _showAlertDialog(BuildContext bctx) {
    showDialog(
        context: bctx,
        builder: (bctx) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text(
              "Do you want to cancel the payment?",
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
              const SizedBox(
                width: 10.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(bctx);
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  void _showMissingDetailsDialog(BuildContext bctx) {
    showDialog(
        context: bctx,
        builder: (bctx) {
          return AlertDialog(
            title: const Text("Incorrect Amount"),
            content: const Text("Please enter non-zero and non-empty value"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  void _incorrectBalanceDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Incorrect amount"),
            content: const Text(
                "The withdrawn amount is more than the balance"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  Container _buttonLabel() {
    return Container(
      padding: globals.stdPadding,
      child: Row(
        children: <Widget>[
          const Icon(Icons.add),
          const SizedBox(width: 6.0),
          Text(
            "Add Payment",
            style: GoogleFonts.ibmPlexMono(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Container _formFieldLabel(String label) {
    return Container(
      margin: globals.stdPadding,
      alignment: Alignment.topLeft,
      child: Text(
        label,
        style: GoogleFonts.ibmPlexMono(fontSize: 16.0),
      ),
    );
  }

  InputDecoration mainInputDecoration() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 82, 121, 184), width: 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 80, 142, 193)),
        borderRadius: BorderRadius.circular(10.0), // Border when enabled
      ),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.red,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    return FloatingActionButton.extended(
        label: _buttonLabel(),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: false,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 16.0,
                      right: 16.0,
                      top: 16.0),
                  child: SingleChildScrollView(
                    child: Consumer(
                        builder: (context, value, child) => Column(
                              children: <Widget>[
                                // Heading -> Add Transaction
                                Text(
                                  "Add Transaction",
                                  style: GoogleFonts.ibmPlexMono(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                    width: double.infinity, height: 12.0),
                                // Text field -> Amount
                                _formFieldLabel("Amount"),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        controller: _controllerAmount,
                                        decoration: mainInputDecoration(),
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                                signed: false),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: DropdownMenu(
                                        controller: _paymentTypeController,
                                        requestFocusOnTap: false,
                                        label: const Text("Type"),
                                        dropdownMenuEntries: const <DropdownMenuEntry>[
                                          DropdownMenuEntry(
                                              value: "Credit", label: "Credit"),
                                          DropdownMenuEntry(
                                              value: "Debit", label: "Debit"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12.0),
                                // Dropdown -> Category
                                _formFieldLabel("Category"),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: DropdownMenu(
                                        controller: _controllerCategory,
                                        dropdownMenuEntries: accountProvider
                                            .acc_categories
                                            .map((String value) {
                                          return DropdownMenuEntry(
                                            value: value,
                                            label: value,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                // Text Field -> Description
                                _formFieldLabel("Description"),
                                TextField(
                                  controller: _controllerDescription,
                                  decoration: mainInputDecoration(),
                                ),
                                const SizedBox(height: 12.0),
                                // Buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    // Cancel button
                                    ElevatedButton(
                                        onPressed: () {
                                          _showAlertDialog(context);
                                        },
                                        child: const Row(
                                          children: <Widget>[
                                            Icon(Icons.cancel),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            Text("Cancel Transaction")
                                          ],
                                        )),
                                    // Submit button
                                    ElevatedButton(
                                      onPressed: () {
                                        // check if amount entered is non-zero
                                        if (_controllerAmount.text.isEmpty || double.parse(_controllerAmount.text) == 0) {
                                          _showMissingDetailsDialog(context);
                                        } else {
                                          Payment p = _generatePayment();
                                          if (accountProvider.acc_balance + p.amount < 0) {
                                            _incorrectBalanceDialog();
                                          } else {
                                            accountProvider.addPayment(p);
                                            _dispose();
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Added Transaction"),
                                                  backgroundColor: Colors.amber,
                                            ));
                                          }
                                        }
                                      },
                                      child: const Row(
                                        children: <Widget>[
                                          Icon(Icons.check),
                                          SizedBox(
                                            width: 6.0,
                                          ),
                                          Text("Submit")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 16.0,)
                              ],
                            )),
                  ),
                );
              });
        });
  }
}
