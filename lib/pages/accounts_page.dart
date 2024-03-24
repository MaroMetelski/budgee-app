import 'package:flutter/material.dart';
import 'package:frontend/pages/account_form_page.dart';
import 'package:frontend/widgets/main_drawer.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => AccountsPageState();
}

class AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      drawer: const MainDrawer(),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
