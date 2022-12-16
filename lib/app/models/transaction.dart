enum TransactionType {
  income("Income"),
  balancing("Balancing"),
  transfer("Transfer"),
  expense("Expense"),
  loanGiven("Loan given"),
  loanTaken("Loan taken");

  final String repr;
  const TransactionType(this.repr);
}

class TransactionModel {
  late final TransactionType type;
  final double amount;
  final String from;
  final String to;
  final String description;
  final String who;
  final List<String> tags;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.from,
    required this.to,
    this.description = "",
    this.who = "",
    this.tags = const [],
  });

  TransactionModel.fromAccountTypes({
    required String cr,
    required String dr,
    required this.amount,
    required this.from,
    required this.to,
    this.description = "",
    this.who = "",
    this.tags = const [],
  }) {
    var type = TransactionType.expense;
    if (cr == "asset" && dr == "expense") {
      type = TransactionType.expense;
    } else if (cr == "income" && dr == "asset") {
      type = TransactionType.income;
    } else if (cr == "asset" && dr == "asset") {
      type = TransactionType.transfer;
    }
    this.type = type;
  }
}
