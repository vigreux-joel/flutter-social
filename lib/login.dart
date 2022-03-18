import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter social",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginPage(title: "login"),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:_FormState().build(context)
      ),
    );
  }

  _FormState createState() {
    return _FormState();
  }
}

class _FormState {
  bool emailValid = false;

  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Column(
          key: GlobalKey<FormState>(),
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              onChanged: (String? email) {
                if (email != null) {
                  if (EmailValidator.validate(email) == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("email invalide"),
                          backgroundColor: Colors.red,
                        )
                    );
                    // TODO changer le design du submit et elever le preventDefault
                  }
                  else{
                    emailValid = true;
                    ScaffoldMessenger.of(context).clearSnackBars();
                  }
                }
              },
              validator: (String? email) {
                if (email == null || email.isEmpty) {
                  return 'Please enter your email';
                }
                else {
                  if (!EmailValidator.validate(email)) {
                    return 'Please enter correct email';
                  }
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (emailValid) {
                    if (GlobalKey<FormState>().currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('email invalide')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}