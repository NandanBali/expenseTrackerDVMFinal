import 'package:expense_tracker_dvm/widgets/reused_components/history_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker_dvm/models/app_models/account.dart';
import 'package:expense_tracker_dvm/models/app_models/payment.dart';

class AccountProvider extends ChangeNotifier {
  Account user_account = Account();
  List<Widget> acct_HistoryCards = <Widget>[];


  // constructor
  AccountProvider();

  // getters
  List<Widget> get acct_history_cards => acct_HistoryCards;
  double get acc_balance => user_account.balance;
  double get acc_month_ex => user_account.monthlyExpense;
  double get acc_month_in => user_account.monthlyIncome;
  List<String> get acc_categories => user_account.categories;


  // setters
  void calcMonthlyExpenses() {
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
    user_account.balance = user_account.monthlyIncome - user_account.monthlyExpense;
    notifyListeners();
  }

  // interface functions
  void addPayment(Payment p) {
    user_account.acctHistory.add(p);
    calcMonthlyExpenses();
    calcMonthlyIncome();
    calculateBalance();
    notifyListeners();
  }

  List<Widget> generateHistoryList(int i) {
    List<Widget> acct_history_widgets = <Widget>[];
    bool _status = (i == -1) ? true : false;
    if (_status) {
      for(Payment p in user_account.acctHistory) {
        acct_history_widgets.add(HistoryCard(p));
        acct_history_widgets.add(SizedBox(height: 8.0));
      }
    } else {
      int length = user_account.acctHistory.length;
      for(int j = 1; j <= i; j++) {
        acct_history_widgets.add(HistoryCard(user_account.acctHistory.elementAt(length - j)));
        acct_history_widgets.add(SizedBox(height: 8.0));
      }
    }
    notifyListeners();
    return acct_history_widgets;
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
    List<Widget> acct_history_widgets = <Widget>[];
    List<Payment> payment_list;
    if(filter != null) {
      payment_list = user_account.acctHistory.where((p) => (p.category == filter)).toList();
    } else {
      payment_list = user_account.acctHistory;
    }
    for (Payment p in payment_list) {
      acct_history_widgets.add(HistoryCard(p));
      acct_history_widgets.add(SizedBox(height: 8.0));
    }

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

  // helper functions
  bool txExpense(Payment p) {
    if (p.amount > 0) {
      return false;
    } else {
      return true;
    }
  }
}