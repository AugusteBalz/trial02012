import 'package:flutter/material.dart';


class NewMood extends StatelessWidget {
  final Function addMood;

  NewMood(this.addMood);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            TextButton(
              child: const Text("Log Mood // Done"),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.deepPurple,
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                addMood();

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
