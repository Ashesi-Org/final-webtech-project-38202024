import 'package:flutter/material.dart';
import 'api_call.dart';
import 'FeedPage.dart';

class AddPost extends StatefulWidget {
  final Map user;

  AddPost({required this.user});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController _controllerPostedCreator = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();


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
                'Create Your Post',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                    hintText: widget.user['email']
                ),
                maxLines: 5,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Add a body'
                ),
                controller: _controllerBody,
                maxLines: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PostsList(user: widget.user);
                      },
                    );

                    Map<String, String> dataToUpdate = {
                      'email': widget.user['email'],
                      'post': _controllerBody.text,
                    };

                    bool status = await api_call().addPost(dataToUpdate);

                    if (status) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Post added')));
                    }
                    else
                    {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Failed to add the post')));
                    }
                  },
                  child: Text('Create Post'))
            ],
          ),
        ),
      ),
    );
  }
}