import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class AdminLogin extends StatelessWidget {
  String _passcode = '8318';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter admin passcode',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            PinEntryTextField(
              onSubmit: (String pin) {
                if (pin == _passcode) {
                  Navigator.pushNamed(context, 'panel');
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Denied"),
                          content: Text("Pin entered is wrong! Try Again."),
                          actions: <Widget>[
                            RaisedButton(
                              child: Text("Try Again"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
