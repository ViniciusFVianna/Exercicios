import 'package:mobx/mobx.dart';
import 'package:mobx_demo/models/todo.model.dart';
part 'todo.store.g.dart';

class TodoStore with Store {
  @observable
  ObservableList<Todo> todos = ObservableList<Todo>();

@action
  void add(Todo todo) {
    todos.add(todo);
  }
}
