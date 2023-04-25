import 'dart:async';

import 'package:flutter/material.dart';
import 'api_call.dart';
import 'PostsPage.dart';

class PostsList extends StatefulWidget {
  final Map user;

  PostsList({required this.user});

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  late Future<List<Map>> _futurePosts;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _futurePosts = api_call().fetchPosts();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    const duration = Duration(seconds: 5);
    _timer = Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          _futurePosts = api_call().fetchPosts();
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
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
                'Post Feed',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddPost(user: widget.user);
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map>>(
        future: _futurePosts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check for errors
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }
          //Has data arrived
          if (snapshot.hasData) {
            List<Map> posts = snapshot.data;

            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Map thisItem = posts[index];
                  return ListTile(
                    title: Text('${thisItem['post creator']}'),
                    subtitle: Text('${thisItem['post']}'),
                  );
                });
          }
          //Display a loader
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
