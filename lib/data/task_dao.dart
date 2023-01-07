import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTERGER, '
      '$_image TEXT) ';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {}

  Future<List<Task>> findAll() async {
    final Database bancoDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDados.query(_tablename);
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefa) {
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefa) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    final Database bancoDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDados
        .query(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
    return toList(result);
  }

  delete(String nomeDaTarefa) async {}
}
