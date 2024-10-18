import 'package:expense_tracker_dvm/widgets/reused_components/history_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker_dvm/models/app_models/account.dart';
import 'package:expense_tracker_dvm/models/app_models/payment.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker_dvm/globals.dart' as globals;

class AccountProvider extends ChangeNotifier {
  final database;
  Account user_account = Account();
  // constructor
  AccountProvider({required this.database}) {
    user_account.readIntoList(database);
  }

  List<Widget> acct_HistoryCards = <Widget>[];
  String _filter = "All";

  // getters
  List<Widget> get acct_history_cards => acct_HistoryCards;
  double get acc_balance => user_account.balance;
  double get acc_month_ex => user_account.monthlyExpense;
  double get acc_month_in => user_account.monthlyIncome;
  List<String> get acc_categories => user_account.categories;
  String get history_filter => _filter;

  // initializer

  // setters
  void calcMonthlyExpenses() {
    user_account.monthlyExpense = 0;
    if (user_account.acctHistory.isNotEmpty) {
      List<Payment> monthTx =
      user_account.acctHistory.where((i) => (txExpense(i))).toList();
      for (int i = 0; i < monthTx.length; i++) {
        user_account.monthlyExpense -= monthTx.elementAt(i).amount;
      }
    }
    notifyListeners();
  }

  void calcMonthlyIncome() {
    user_account.monthlyIncome = 0;
    if (user_account.acctHistory.isNotEmpty) {
      List<Payment> monthTx =
      user_account.acctHistory.where((i) => (!txExpense(i))).toList();
      for (int i = 0; i < monthTx.length; i++) {
        user_account.monthlyIncome += monthTx.elementAt(i).amount;
      }
    }
    notifyListeners();
  }

  void calculateBalance() {
    user_account.balance = 0;
    user_account.balance = user_account.monthlyIncome - user_account.monthlyExpense;
    notifyListeners();
  }

  // interface functions
  void addPayment(Payment p) {
    user_account.acctHistory.add(p);
    calcMonthlyExpenses();
    _filter = "All";
    calcMonthlyIncome();
    calculateBalance();
    user_account.insertPayment(p, database);
    notifyListeners();
  }

  List<Widget> generateHistoryList_temp() {
    List<Widget> acct_history_widgets = <Widget>[];
    for(Payment p in user_account.acctHistory) {
      acct_history_widgets.add(HistoryCard(p));
      acct_history_widgets.add(SizedBox(height: 8.0));
    }
    notifyListeners();
    return acct_history_widgets;
  }

  List<Widget> generateHistoryList_filtered(String? filter) {
    List<Payment> initList = user_account.acctHistory;
    List<Widget> acct_history_widgets = <Widget>[];
    List<Payment> payment_list;
    if(filter != "All") {
      payment_list = user_account.acctHistory.where((p) => (p.category == filter)).toList();
    } else {
      payment_list = user_account.acctHistory;
    }
    if (payment_list.isEmpty) {
      acct_history_widgets.add(Padding(padding: globals.stdPadding, child: Align(alignment: Alignment.center ,child: Text("No Payments found with category ${filter}", style: GoogleFonts.ibmPlexSans(fontStyle: FontStyle.italic, fontSize: 48.0),))));
      return acct_history_widgets;
    }
    for (Payment p in payment_list) {
      acct_history_widgets.add(HistoryCard(p));
      acct_history_widgets.add(SizedBox(height: 8.0));
    }
    user_account.acctHistory = initList;
    notifyListeners();
    return acct_history_widgets;
  }

  void addWidgets(String? filter) {
    if(filter == null){
      acct_HistoryCards = generateHistoryList_temp();
    } else {
    }
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  // helper functions
  bool txExpense(Payment p) {
    if (p.amount > 0) {
      return false;
    } else {
      return true;
    }
  }
}