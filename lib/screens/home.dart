// import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/widgets/todo_list.dart';
import 'package:todo_list/model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> foundItem = [];
  final TextEditingController _todoController = TextEditingController();


  // late DatabaseReference dbRef;

  

  @override
  initState() {
    // This's like a database to store all todo items.
    // When the first init state
    foundItem = todosList;
    super.initState();
    // _todoController.addListener(_printLatestValue);
    // dbRef = FirebaseDatabase.instance.ref().child("TodoList");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'All Todos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in foundItem.reversed)
                        TodoList(
                          todo: todoo,
                          onToDoChange: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                          onEditItem: _editToDoItem,
                          myList: _newList,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Add new task widget
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 10,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new task!',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  //Add task button
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),


                    onPressed: () {
                      print("Add new task.");
                      if (_todoController.text.isNotEmpty && !foundItem.any((item) => item.todoText == _todoController.text)) {
                        _addToDoItem(_todoController.text.trim());
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Warning'),
                              content: const Text('Task is empty or already exists.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      // Map<String, String> tasks = {
                      //   "task": _todoController.text
                      // };
                      // dbRef.push().set(tasks).then((_) {
                      //   print("Added to Firebase");
                      // }).catchError((onError) {
                      //   print("Error: $onError");
                      // });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: tdBlue,
                      minimumSize: Size(70, 70),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(
      () {
        todosList.removeWhere((item) => item.id == id);
      },
    );
  }

  void _editToDoItem(String id, String newTodoText) {
  setState(() {
    // Find the todo item with the specified id
    ToDo? todoToEdit = todosList.firstWhere((item) => item.id == id);

      // Update the todoText of the found item
      todoToEdit.todoText = newTodoText;
    
  });
}
  void _newList(List<ToDo> newList) {
    setState(() {
      foundItem = newList;
    });
  }


  void _runFilter(String enterKeyword) {
    List<ToDo> results = [];
    if (enterKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundItem = results;
    });
  }

  void _addToDoItem(String toDo) {
    setState(
      () {
        todosList.add(
          ToDo(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              todoText: toDo),
        );
      },
    );
    _todoController.clear();
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxWidth: 20,
              maxHeight: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdBlack)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/vichet2.png',
                  scale: 1.0,
                ),
              ),
            )
          ],
        ));
  }
}
