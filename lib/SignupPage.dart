import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'api_call.dart';
import 'LoginPage.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@ashesi.edu.gh$");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this!=null;
  }

  bool get isValidDateOfBirth {
    final dateOfBirthRegExp = RegExp(r"^\d{2}/\d{2}/\d{4}$");
    if (!dateOfBirthRegExp.hasMatch(this)) return false;
    try {
      DateTime.parse(this);
      final now = DateTime.now();
      final dob = DateTime.parse(this);
      if (dob.isAfter(now)) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get isValidYear {
    final yearRegExp = RegExp(r"^\d{4}$");
    final intYear = int.tryParse(this);
    if (intYear == null) {
      return false;
    }
    return yearRegExp.hasMatch(this);
  }
}



class _SignupPageState extends State<SignupPage> {
  bool _isOnCampusResidence = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _yearGroupController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _favouriteFoodController = TextEditingController();
  final TextEditingController _favouriteMovieController = TextEditingController();

  @override
  void dispose() {
    _studentIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _yearGroupController.dispose();
    _majorController.dispose();
    _favouriteFoodController.dispose();
    _favouriteMovieController.dispose();
    super.dispose();
  }

  void _onToggleCampusResidence(bool? value) {
    setState(() {
      _isOnCampusResidence = value ?? false;
    });
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
              const SizedBox(width: 10),
              Text(
                'Sign Up',
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Student ID'),
                controller: _studentIdController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty || value.length != 8) {
                    return 'Please enter your student ID (Must be 8 digits)';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty || !value.isValidName) {
                    return 'Please enter your full name';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty || !value.isValidEmail || !value.isNotNull) {
                    return 'Please enter your email';
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || !value.isValidPassword || !value.isNotNull) {
                    return 'Please enter your password';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'Date of Birth (DD/MM/YYYY)'),
                controller: _dobController,
                validator: (value) {
                  if (value!.isEmpty || !value.isNotNull || value.isValidDateOfBirth) {
                    return 'Please enter your date of birth';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Year Group'),
                controller: _yearGroupController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty || !value.isValidYear || !value.isNotNull) {
                    return 'Please enter your year group (Must be 4 digits long)';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Major'),
                controller: _majorController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your major';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Favourite Food'),
                controller: _favouriteFoodController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your favourite food';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Favourite Movie'),
                controller: _favouriteMovieController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your favourite movie';
                  }
                },
              ),
              Row(
                children: [
                  Switch(
                    value: _isOnCampusResidence,
                    onChanged: _onToggleCampusResidence,
                  ),
                  Text('On Campus Residence'),
                ],
              ),
            Container(
                margin: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var student_id = int.parse(_studentIdController.text);
                    var year_group = int.parse(_yearGroupController.text);
                    Map signupData = {
                      'student_id': student_id,
                      'name': _nameController.text,
                      'password': _passwordController.text,
                      'email': _emailController.text,
                      'dob': _dobController.text,
                      'year_group': year_group,
                      'major': _majorController.text,
                      'favourite_food': _favouriteFoodController.text,
                      'favourite_movie': _favouriteMovieController.text,
                      'on_campus_residence': _isOnCampusResidence
                    };
                    print(signupData);
                    bool signedup = await api_call().signUp(signupData);
                    print(signedup);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.black),
                child: Text('Sign Up'),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

