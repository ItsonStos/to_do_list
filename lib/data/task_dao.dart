import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/data/database.dart';
import 'package:to_do_list/data/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskDao {
  ///CRIANDO O MÉTODO PARA ENCOTRAR TODOS DADOS DA TABELA
  Future<List<TaskModel>> findAll() async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tableTask);
    return result.map<TaskModel>((map) => TaskModel.fromMap(map)).toList();
  }

  ///CRIANDO O MÉTODO PARA ENCOTRAR UM DADOS ESPECÍFICO DA TABELA
  Future<List<TaskModel>> find(String nameTask) async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tableTask,
      where: '${TaskModel.kTask} = ?',
      whereArgs: [nameTask],
    );
    return result.map<TaskModel>((map) => TaskModel.fromMap(map)).toList();
  }

  ///CRIANDO O MÉTODO SALVAR E ATUALIZAR
  Future<int> save(String task, String pathImage, int difficult) async {
    final Database database = await getDatabase();
    final List<TaskModel> itemExistis = await find(task);
    final Map<String, dynamic> taskMap = TaskModel(id: const Uuid().v4(), task: task, difficult: difficult, image: pathImage).toMap();
    if (itemExistis.isEmpty) {
      return await database.insert(_tableTask, taskMap);
    } else {
      return await database.update(_tableTask, taskMap, where: '${TaskModel.kTask} = ?', whereArgs: [task]);
    }
  }

  ///CRIANDO O MÉTODO QUE DELETAR UMA TAREFA SALVA NO BANCO DE DADOS
  Future<int> delete(String nameTask) async {
    final Database database = await getDatabase();
    return await database.delete(_tableTask, where: '${TaskModel.kTask} = ?', whereArgs: [nameTask]);
  }

  String createTable() {
    return '''CREATE TABLE $_tableTask (
      ${TaskModel.kId} TEXT PRIMARY KEY, 
      ${TaskModel.kTask} TEXT, 
      ${TaskModel.kDifficulty} INTERGER, 
      ${TaskModel.kImage} TEXT
    )''';
  }

  final String _tableTask = 'taskTable';
}
