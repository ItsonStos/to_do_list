import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/data/task_dao.dart';

const String _kDataBaseName = 'task.db';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), _kDataBaseName);
  return openDatabase(
    path,
    onCreate: (db, vercion) {
      db.execute(TaskDao().createTable());
    },
    version: 1,
  );
}
