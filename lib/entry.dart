import 'api/api.dart';
import 'api/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  late Future<List<Entry>> futureEntries;

  @override
  void initState() {
    super.initState();
    futureEntries = Provider.of<ApiService>(context, listen: false).getEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entries"),
      ),
      body: Center(
        child: FutureBuilder<List<Entry>>(
          future: futureEntries,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var currentEntry = snapshot.data![index];
                  return ListTile(
                    /* If entry.cr == asset -> minus sign */
                    leading: Text(currentEntry.cr == "checking" ? "-${currentEntry.amount}" : currentEntry.amount),
                    title: Text(currentEntry.cr),
                    subtitle: Text(currentEntry.dr),
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
