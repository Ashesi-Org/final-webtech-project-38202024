import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'UsersProfilePage.dart';
import 'api_call.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _studentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'logo.png',
                height: 400,
              ),
              SizedBox(width: 10),
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _studentIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Student ID'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 8) {
                    return 'Please enter your student ID';
                  }
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                },

              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // do something when the form is valid
                      var studentId = int.parse(_studentIdController.text);
                      Map <String, dynamic>loginData = { 'student_id': studentId, 'password': _passwordController.text};
                      print(loginData);
                      Map loggedin = await api_call().logIn(studentId, _passwordController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UsersProfilePage(userData: loggedin)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black),
                  child: Text('Log In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
