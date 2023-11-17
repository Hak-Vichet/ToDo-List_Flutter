import 'package:todo_list/widgets/todo_list.dart';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Check email', isDone: true),
      ToDo(id: '02', todoText: 'Eating breakfast', isDone: true),
      ToDo(id: '03', todoText: 'Go to working', isDone: false),
      ToDo(id: '04', todoText: 'Working in office', isDone: true),
      ToDo(id: '04', todoText: 'Go to have meeting', isDone: false),
      ToDo(id: '05', todoText: 'Finish working', isDone: true),
    ];
  }
}
