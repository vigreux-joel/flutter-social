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
      home: const LoginPage(title: "null"),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child:_FormState(emailValid: false).widget
      ),
    );
  }

  @override
  State<LoginPage> createState() => _FormState(emailValid: false);

}
//
// class _LoginPageState extends State<LoginPage> {
//
//
//   State createState() => _FormState();
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

class _FormState extends State<LoginPage> {
   _FormState({required this.emailValid});

  bool emailValid = false;

  void changeBackgroundSubmit(a){
    setState(() {
      emailValid = a;
    });
  }

  @override
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
                    emailValid = false;
                    // _SubmitState().emailValid = false;
                    // TODO changer le design du submit
                  }
                  else{
                    emailValid = true;
                    ScaffoldMessenger.of(context).clearSnackBars();
                    // _SubmitState().emailValid = true;
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
            _SubmitState().widget,
          ],
        ),
      ),
    );
  }



// Submit createState() => Submit(emailValid: (bool emailValid) { emailValid; },);

}

class Submit extends StatefulWidget {
   const Submit({required this.emailValid, Key? key}) : super(key: key);

  final bool emailValid;
// bool get emailValid => this.emailValid;
  @override
  State<StatefulWidget> createState() => _SubmitState();
}


class _SubmitState extends State<Submit>{

  bool emailValid = false;

  void _validateEmail(bool a) {
    setState(() {
      if (a) {
        emailValid = true;
      }
      else {
        emailValid = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List color = [MaterialStateProperty.all<Color>(Colors.red), Theme.of(context).primaryColor];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (emailValid) {
            if (GlobalKey<FormState>().currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
                //  TODO server treatment
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
        style: ButtonStyle(
            backgroundColor: color[emailValid ? 1 : 0],
        )
      ),
    );
  }


}
