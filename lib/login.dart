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
      home: LoginPage(title: "login"),
    );
  }
}

@immutable
class LoginPage extends StatefulWidget{
   LoginPage({Key? key, required this.title}) : super(key: key);


   final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: _FormState(validateEmail: false,
            colorBackInput: [
            MaterialStateProperty.
            all(Colors.green),
            MaterialStateProperty.
            all(Colors.red)]).widget
      ),
    );
  }

  List <MaterialStateProperty<MaterialColor>> backgroundsColor =
  [
    MaterialStateProperty.all(Colors.green),
    MaterialStateProperty.all(Colors.red),
  ];

  @override
  State createState() => _FormState(validateEmail: false, colorBackInput: backgroundsColor);
}

class _FormState extends State<LoginPage> implements SubmitState  {

  var validateEmail = false;

  @override
  late List color;

  _FormState({ required this.validateEmail, required List
  <MaterialStateProperty<MaterialColor>> this.colorBackInput });

  List colorBackInput = [
    MaterialStateProperty.all(Colors.green),
    MaterialStateProperty.all(Colors.red)

  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
          body: Column(
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
                        validateEmail = true;

                        // TODO changer le design du submit
                      }
                      else {

                        validateEmail = false;
                        ScaffoldMessenger.of(context).clearSnackBars();
                      }
                    }
                    else {
                      validateEmail = false;
                    }
                    setState1(SubmitState(validateEmail: validateEmail).checkSyntaxEmail(validateEmail));
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
                // SubmitStateTEST(validateEmail: validateEmail,).buttonInput(context),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (validateEmail != false) {
                          if (GlobalKey<FormState>().currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                              //  TODO server treatment
                            );
                          }
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('email invalide')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    // split le style du bouton et ladapter par rapport au info du person
                      style: ButtonStyle(
                        print(validateEmail),
                        print(colorBackInput),
                      backgroundColor: _background(validateEmail, colorBackInput)
                      ),
                  ),
                )
              ]
          )
      ),
    );
  }

  @override
  checkSyntaxEmail(bool validateEmail) {
    // TODO: implement checkSyntaxEmail
    throw UnimplementedError();
  }

  @override
  // TODO: implement backgroundColor
  List get backgroundColor => throw UnimplementedError();
}


class Submit extends StatefulWidget {
   const Submit({Key? key, required this.validateEmail}) : super(key: key);
  final bool validateEmail;

  @override
  State<StatefulWidget> createState() => SubmitState(validateEmail: false);

}
class SubmitState extends State<LoginPage> {
  bool validateEmail;

  SubmitState({required this.validateEmail});

  List color = [
    MaterialStateProperty.all(Colors.green),
    MaterialStateProperty.all(Colors.red)
  ];

  checkSyntaxEmail(bool validateEmail) {
    if (!validateEmail) {
      return Colors.red;
    }
    else {
      return Colors.green;
    }
  }

  @override
    void setState1(VoidCallback fn) {
    final bool validateEmail = fn() as dynamic;
    super.setState(fn);
  }

  _background (validateEmail, colorBackInput) {
    if (validateEmail) {
      return colorBackInput[validateEmail ? 1 : 0];
    }
  }

  @override
  Widget build(BuildContext context) {
//TODO fonction de build du bouton
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 16.0),
  //       child: ElevatedButton(
  //         onPressed: () {
  //           if (validateEmail) {
  //             if (GlobalKey<FormState>().currentState!.validate()) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text('Processing Data')),
  //                 //  TODO server treatment
  //               );
  //             }
  //           }
  //           else {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('email invalide')),
  //             );
  //           }
  //         },
  //         child: const Text('Submit'),
  //         style: ButtonStyle(
  //           backgroundColor: _background(validateEmail, color),
  //         )
  //       ),
  //     );
  //   }
  }



