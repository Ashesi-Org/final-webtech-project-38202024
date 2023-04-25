import 'FeedPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PostsPage.dart';
import 'api_call.dart';

extension extString on String {

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

class UsersProfilePage extends StatefulWidget {
  final Map userData;

  UsersProfilePage({required this.userData});


  @override
  _UsersProfilePageState createState() => _UsersProfilePageState();
}

class _UsersProfilePageState extends State<UsersProfilePage> {
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
                'View Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditModal(user: widget.userData);
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[200],
              onPrimary: Colors.black,
            ),
            child: Text('Edit'),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddPost(user: widget.userData);
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[200],
              onPrimary: Colors.black,
            ),
            child: Text('Create Post'),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PostsList(user: widget.userData);
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[200],
              onPrimary: Colors.black,
            ),
            child: Text('View Posts'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  color: Colors.black,
                ),
                Positioned(
                  bottom: 50.0,
                  right: 100.0,
                  child: Container(
                    height: 400.0,
                    width: 400.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.0),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100.0,
                  left: 150.0,
                  child: Container(
                    height: 300.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 140.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70.0),
                        image: DecorationImage(
                          image: AssetImage('profilePic.png'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 5.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    SizedBox(height: 60.0),
            Row(
              children: [
                Text(
                  'ID: ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.userData['student_id'].toString(),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.0),
    Row(
    children: [
    Text(
    'Name: ',
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    widget.userData['name'],
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    SizedBox(height: 60.0),
    Row(
    children: [
    Text(
    'Email: ',
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    widget.userData['email'],
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    SizedBox(height: 60.0),
    Row(
    children: [
    Text(
    'Date of Birth: ',
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Text(
    widget.userData['dob'],
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.0,
    color: Colors.grey[700],
    ),
    textAlign: TextAlign.center,
    ),
    ),
    ],
    ),
    SizedBox(height: 60.0),
    Row(
    children: [
    Text(
    'Year Group: ',
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    widget.userData['year_group'].toString(),
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    SizedBox(height: 60.0),
    Row(
    children: [
    Text(
    'Major: ',
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    widget.userData['major'],
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    SizedBox(height: 60.0),
    Row(
    children: [
    Text(
    'Favourite Food: ',
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Text(
    widget.userData['favourite_food'],
    style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.0,
      color: Colors.grey[700],
    ),
      textAlign: TextAlign.center,
    ),
    ),
    ],
    ),
            SizedBox(height: 60.0),
            Row(
              children: [
                Text(
                  'Favourite Movie: ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    widget.userData['favourite_movie'],
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.0),
            Row(
              children: [
                Text(
                  'On campus residence: ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    widget.userData['on_campus_residence'].toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}



class EditModal extends StatefulWidget {
  final Map user;

  EditModal({required this.user});

  @override
  _EditModalState createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  bool _isOnCampusResidence = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _yearGroupController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _favouriteFoodController = TextEditingController();
  final TextEditingController _favouriteMovieController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _dobController.dispose();
    _yearGroupController.dispose();
    _majorController.dispose();
    _favouriteFoodController.dispose();
    _favouriteMovieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isOnCampusResidence = widget.user['on_campus_residence'];
  }

  void _onToggleCampusResidence(bool newValue) {
    setState(() {
      _isOnCampusResidence = newValue;
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
                'Edit Profile',
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
              Row(
                children: [
              Text(
                'Student ID: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                widget.user['student_id'].toString(),
                style: TextStyle(fontSize: 16),
              ),
              ],
          ),
              Row(
                children: [
                  Text(
                'Full Name: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                widget.user['name'],
                style: TextStyle(fontSize: 16),
                  ),
                ],
          ),
              Row(
                children: [
              Text(
                'Email: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.user['email'],
                style: TextStyle(fontSize: 16),
              ),
          ],
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password', hintText: widget.user['password']),
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
                decoration: InputDecoration(labelText: 'Year Group', hintText: widget.user['year_group'].toString()),
                controller: _yearGroupController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty || !value.isValidYear || !value.isNotNull) {
                    return 'Please enter your year group (Must be 4 digits long)';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Major', hintText: widget.user['major']),
                controller: _majorController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your major';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Favourite Food', hintText: widget.user['favourite_food']),
                controller: _favouriteFoodController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your favourite food';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Favourite Movie', hintText: widget.user['favourite_movie']),
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
                      var year_group = int.parse(_yearGroupController.text);
                      Map editData = {
                        'password': _passwordController.text,
                        'dob': _dobController.text,
                        'year_group': year_group,
                        'major': _majorController.text,
                        'favourite_food': _favouriteFoodController.text,
                        'favourite_movie': _favouriteMovieController.text,
                        'on_campus_residence': _isOnCampusResidence
                      };
                      print(editData);
                      Map edited = (await api_call().edit(editData, widget.user['student_id'])) as Map;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UsersProfilePage(userData: edited)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black),
                  child: Text('Save edit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
