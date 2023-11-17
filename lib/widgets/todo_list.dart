import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo.dart';

class TodoList extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;

  const TodoList(
      {Key? key,
      required this.todo,
      required this.onToDoChange,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        tileColor: Colors.white,
        onTap: () {
          print("Clicked on Todo Items.");
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        textColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          width: 35,
          height: 35,
          // color: tdRed,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            // color: Colors.white,
            iconSize: 18,
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              print("Clicked to delete item.");
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
