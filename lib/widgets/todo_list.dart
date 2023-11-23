import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo.dart';
// import 'package:todo_list/widgets/todo_list.dart'

class TodoList extends StatefulWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;
  final onEditItem;
  final myList;

  // final todosList = ToDo.todoList();
  // List<ToDo> foundItem = [];

  

  // OverlayEntry overlayEntry;

  const TodoList(
      {Key? key,
      required this.todo,
      required this.onToDoChange,
      required this.onDeleteItem,
      required this.onEditItem,
      required this.myList})
      : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
  // _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late TextEditingController _editingController;
  late bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.todo.todoText);
    _isEditing = false;
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        tileColor: widget.todo.isDone ? tdGray : Colors.white,
        onTap: () {
          print("Clicked on Todo Items.");
          widget.onToDoChange(widget.todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        textColor: Colors.white,
        leading: Icon(
            widget.todo.isDone
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: tdBlue),

        title: _isEditing
            ? TextField(
                controller: _editingController,
                style: TextStyle(
                  fontSize: 16,
                  color: tdBlack,
                  decoration:
                      widget.todo.isDone ? TextDecoration.lineThrough : null,
                ),
              )
            : Text(
                widget.todo.todoText!,
                style: TextStyle(
                  fontSize: 16,
                  color: tdBlack,
                  decoration:
                      widget.todo.isDone ? TextDecoration.lineThrough : null,
                ),
              ),

        // Actions buttons "Edit" & "Delete"
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              // visible: !todo.isDone,
              visible: !_isEditing && !widget.todo.isDone,
              child: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  iconSize: 18,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle the edit button click
                    print("Clicked to edit item.");
                    setState(() {
                      _isEditing = true;
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _isEditing ? Colors.green : tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: _isEditing
                  ? IconButton(
                      iconSize: 18,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle the edit button click
                        print("Clicked to save item.");
                        if ( _editingController.text.isNotEmpty ) {
                          // print(o)
                          setState(() {
                            _isEditing = false;
                            // widget.onToDoChange(widget.todo.copyWith(
                            //   todoText: _editingController.text,
                            // ));
                            widget.onEditItem(
                                widget.todo.id, _editingController.text);

                            print("Id: ${widget.todo.id}");
                            print("Edited item: ${_editingController.text}");
                          });
                        }
                      },
                    )
                  : IconButton(
                      iconSize: 18,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        print("Clicked to delete item.");
                        widget.onDeleteItem(widget.todo.id);

                        // showDialog(
                        //   // barrierColor: Colors.red,
                        //   context: context,
                        //   builder: (context) {
                        //     return AlertDialog(
                        //       title: const Text('Congratulations'),
                        //       content: const Text('Successfully deleted task!'),
                        //       actions: [
                        //         TextButton(
                        //           onPressed: () {
                        //             Navigator.pop(context);
                        //           },
                        //           child: const Text('OK'),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
