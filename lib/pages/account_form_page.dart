import 'package:flutter/material.dart';
import 'package:frontend/database.dart';
import 'package:frontend/models/account_model.dart';

enum CategoryLabel {
  groceries('Groceries', Colors.blue),
  rent('Rent', Colors.amber);

  const CategoryLabel(this.label, this.color);
  final String label;
  final Color color;
}

class AccountFormPage extends StatefulWidget {
  const AccountFormPage({super.key});

  @override
  State<AccountFormPage> createState() => _AccountFormPageState();
}

class _AccountFormPageState extends State<AccountFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  CategoryLabel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add account'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nameController,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String name = _nameController.text;
                  AccountModel account = AccountModel(
                    name: name,
                    type: 'monetaryAsset',
                  );
                  DatabaseHelper.instance.addAccount(account);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Account added'),
                    duration: Duration(seconds: 1),
                  ));
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
