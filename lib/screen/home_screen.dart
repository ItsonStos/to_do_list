import 'package:flutter/material.dart';
import 'package:to_do_list/components/task_tile.dart';
import 'package:to_do_list/data/task_dao.dart';
import 'package:to_do_list/data/task_model.dart';
import 'package:to_do_list/screen/form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TaskDao _taskDao;
  late Future<List<TaskModel>> _futureTaskTile;

  @override
  void initState() {
    super.initState();
    _taskDao = TaskDao();
    _futureTaskTile = _taskDao.findAll();
  }

  Future<dynamic> _openFormModal() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (contextNew) {
        return const FormScreen();
      },
    );
    setState(() {
      _futureTaskTile = _taskDao.findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Tarefas'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: _openFormModal,
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<TaskModel>>(
          future: _futureTaskTile,
          builder: (context, snapshot) {
            final List<TaskModel>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskTile(items.elementAt(index));
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.error_outline,
                          size: 28,
                        ),
                        Text(
                          'Não há nenhuma tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: Text('Erro ao carregar tarefas!'));
            }
            //return const Text('Erro desconhecido!');
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openFormModal,
        elevation: 30,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
