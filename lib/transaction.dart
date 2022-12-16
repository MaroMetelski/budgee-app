import 'package:frontend/app/models/transaction.dart';

import 'app/app.dart';
import 'api/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  late Future<List<TransactionModel>> futureTransactions;

  @override
  void initState() {
    super.initState();
    futureTransactions = Provider.of<Application>(context, listen: false).getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entries"),
      ),
      body: Center(
        child: FutureBuilder<List<TransactionModel>>(
          future: futureTransactions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var currentTransaction = snapshot.data![index];
                  return ListTile(
                    /* If entry.cr == asset -> minus sign */
                    leading: Text(currentTransaction.type.repr),
                    title: Text(currentTransaction.from),
                    subtitle: Text(currentTransaction.to),
                    trailing: Text(currentTransaction.amount.toString()),
                  );
                }
              );
            } else if (snapshot.hasError) {
              return Text("loading error: ${snapshot.error}");
            } else {
              return const Text("Loading...");
            }
          }
        ),
      ),
    );
  }
}
