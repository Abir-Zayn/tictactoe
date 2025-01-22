import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuitConfirmationDialog extends StatelessWidget {
  const QuitConfirmationDialog({super.key});

  // Static method to show the dialog
  static Future<bool> show(BuildContext context) async {
    return await showDialog(
          context: context,
          barrierDismissible: false, // User must tap a button
          builder: (BuildContext context) {
            return const QuitConfirmationDialog();
          },
        ) ??
        false; // Return false if dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text(
        'Quit Game',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Are you sure you want to quit?',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            'No',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop(); // This will quit the app
          },
          child: const Text(
            'Yes',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

// To use this in your main.dart or home_screen.dart, wrap your Scaffold with WillPopScope:
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await QuitConfirmationDialog.show(context);
      },
      child: Scaffold(
        // Your existing scaffold content
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
        ),
        body: const Center(
          child: Text('Your game content here'),
        ),
      ),
    );
  }
}
