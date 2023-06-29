import 'package:flutter/material.dart';
import 'package:my_app/input.dart';
import 'package:my_app/amplify_services.dart';
import 'package:my_app/appync_services.dart';
import 'package:my_app/request.dart';
import 'dart:convert';
import 'package:my_app/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<UserModel> users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await configureAmplify();
    await listUsers();
  }

  Future<void> listUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final apiResponse = await listItems(listUsersQuery);
      final jsonResponse = json.decode(apiResponse);
      final userItems = jsonResponse['listUserModels']['items'];
      final List<UserModel> userLists = userItems
          .map<UserModel>((item) => UserModel(
                id: item['id'],
                name: item['name'],
              ))
          .toList();

      setState(() {
        users = userLists;
      });
    } catch (e) {
      print('listUsers error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createUser(value) async {
    try {
      await createItem(createUserQuery, {
        "input": {"name": value}
      });
      await listUsers();
    } catch (e) {
      print('createUser error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : users.isEmpty
                        ? const Center(
                            child: Text('Empty'),
                          )
                        : ListView(
                            children: [
                              Column(
                                children: users
                                    .map<Widget>(
                                      (user) => ListTile(
                                        title: Text(user.name),
                                        subtitle: Text(user.id),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Input(
                  onTap: (value) => {createUser(value)},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
