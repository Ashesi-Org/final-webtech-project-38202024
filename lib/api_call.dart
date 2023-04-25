import 'package:http/http.dart' as http;
import 'dart:convert';


class api_call {
  Future <bool> signUp(Map formData) async {
    bool status = false;
    final String apiUrl = 'https://us-central1-final-webtech-project.cloudfunctions.net/final-webtech-project/users';


      http.Response response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(formData),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        print(response);
        // Form submitted successfully
        print('Form submitted successfully');
        bool status = true;
      } else {
        // Handle form submission failure
        print('Failed to submit form');

      }return status;
    }

  Future <Map> logIn(int student_id, String password) async {
    Map student = {};
    final String apiUrl = 'https://us-central1-final-webtech-project.cloudfunctions.net/final-webtech-project/users?student_id=$student_id';

    final loginData = {'student_id': student_id, 'password': password};
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      print(response);
      student = jsonDecode(response.body);
      print(student);
      // Login successful
      print('Login successful');

    } else {
      // Handle login failure
      print('Login failed');
    }
    return student;
  }

  Future <bool> edit(Map formData, int student_id) async {
    Map student = {};
    bool status = false;
    final String apiUrl = 'https://us-central1-final-webtech-project.cloudfunctions.net/final-webtech-project/users?student_id=$student_id';

    final loginData = {'student_id': student_id};
    http.Response response = await http.patch(Uri.parse(apiUrl),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print(response);
      // Form submitted successfully
      print('Form edited successfully');
      bool status = true;
    } else {
      // Handle form submission failure
      print('Failed to edit form');
    }return status;
  }

  Future <bool> addPost(Map formData) async {
    bool status = false;
    final String apiUrl = 'https://us-central1-final-webtech-project.cloudfunctions.net/final-webtech-project/posts';


    http.Response response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode(formData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      print(response);
      // Form submitted successfully
      print('Form submitted successfully');
      status = true;
    } else {
      // Handle form submission failure
      print('Failed to submit form');
    }return status;
  }

  Future<List<Map<dynamic, dynamic>>> fetchPosts() async {
    List<Map<dynamic, dynamic>> allPosts = [];
    final String apiUrl =
        'https://us-central1-final-webtech-project.cloudfunctions.net/final-webtech-project/posts';

    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Decode response body from JSON to a List of Maps
      List<dynamic> responseBody = jsonDecode(response.body);
      allPosts = responseBody
          .map((post) => {
        'post creator': post['post creator'], // add email field
        'post': post['post']
      })
          .toList();
      print(allPosts);
      print('Posts fetched successfully');
    } else {
      print('Failed to fetch posts. Status code: ${response.statusCode}');
    }
    return allPosts;
  }

}
