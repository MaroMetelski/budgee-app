import 'package:flutter/foundation.dart';

import '../api/models/entry.dart';
import '../api/models/account.dart';
import '../app/models/transaction.dart';

import '../api/api.dart';

class Application extends ChangeNotifier {
  final ApiService api;
  Application(this.api);
  List<Entry> _entries = [];

  // load entries if needed, translate and return
  Future<List<TransactionModel>> getTransactions() async {
    // TODO: This should be different, e.g. filter entries
    // by account type, not only account name in API.
    _entries = await api.getEntries();
    List<TransactionModel> transactions = [];
    for (var entry in _entries) {
      Account accountCr = (await api.getAccounts(name: entry.cr)).first;
      Account accountDr = (await api.getAccounts(name: entry.dr)).first;
      transactions.add(
        TransactionModel.fromAccountTypes(
          cr: accountCr.type,
          dr: accountDr.type,
          amount: double.parse(entry.amount),
          from: entry.cr,
          to: entry.dr,
          description: entry.description,
          who: entry.who,
          tags: entry.tags,
        ));
    }
    return transactions;
  }
}
