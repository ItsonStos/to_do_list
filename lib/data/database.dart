import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../components/task.dart';

///DEFININDO O MODELO DOS DADOS
class TableTask {
  int id;
  String task;
  int difficult;
  String image;

  TableTask(
      {required this.id,
      required this.task,
      required this.difficult,
      required this.image});
}

///(ABRINDO) O BANCO DE DADOS
Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(
    path,
    onCreate: (db, vercion) {
      db.execute('tabela.sql');
    },
    version: 1,
  );
}

///CRIANDO A TABELA
class CreatTableTask {
  static const String tableSql = 'CREATE TABLE $_tableTask('
      '$_id INTERGER PRIMARY KEY, '
      '$_task TEXT, '
      '$_difficulty INTERGER, '
      '$_image TEXT) ';

  static const String _tableTask = 'taskTable';
  static const String _id = 'id';
  static const String _task = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  //CONVERTENDO OS DADOS EM UM MAPA
  Map<String, dynamic> toMap(Task tarefa) {
    final Map<String, dynamic> taskMap = {};
    taskMap[_task] = tarefa.name;
    taskMap[_difficulty] = tarefa.difficulty;
    taskMap[_image] = tarefa.photo;
    return taskMap;
  }

  ///CONVERTENDO OS DADOS EM UMA LISTA
  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    final List<Task> taskList = [];
    for (Map<String, dynamic> linha in taskMap) {
      final Task task = Task(
        linha[_task],
        linha[_image],
        linha[_difficulty],
      );
      taskList.add(task);
    }
    return taskList;
  }

  ///CRIANDO O MÉTODO PARA ENCOTRAR TODOS DADOS DA TABELA
  Future<List<Task>> findAll() async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tableTask);
    return toList(result);
  }

  ///CRIANDO O MÉTODO PARA ENCOTRAR UM DADOS ESPECÍFICO DA TABELA
  Future<List<Task>> find(String nameTask) async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database
        .query(_tableTask, where: '$_task ?', whereArgs: [nameTask]);
    return toList(result);
  }

  ///CRIANDO O MÉTODO SALVAR E ATUALIZAR
  save(Task task) async {
    final Database database = await getDatabase();
    var itemExistis = await find(task.name);
    Map<String, dynamic> taskMap = toMap(task);
    if (itemExistis.isEmpty) {
      return await database.insert(_tableTask, taskMap);
    } else {
      return await database.update(_tableTask, taskMap,
          where: '$_task = ?', whereArgs: [task.name]);
    }
  }

  ///CRIANDO O MÉTODO QUE DELETAR UMA TAREFA SALVA NO BANCO DE DADOS
  delete(String nameTask) async {
    final Database database = await getDatabase();
    return await database
        .delete(_tableTask, where: '$_task = ?', whereArgs: [nameTask]);
  }
}
