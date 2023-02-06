import 'package:flutter/material.dart';
import 'package:to_do_list/components/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('Tarefas'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: ((context, index) {
          return Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Task('Estudar Flutter', 'assets/images/dash.png', 3),
              const Task('Correr', 'assets/images/run.jpg', 1),
              const Task('Trabalhar', 'assets/images/work.jpg', 5),
              const Task('Jogar', 'assets/images/play.jpg', 1),
              const Task('Andar de Bike', 'assets/images/bike.webp', 2),
              const Task('Ler', 'assets/images/livro.jpg', 3),
              const Task('Nadar', 'assets/images/nophoto.png', 4),
              const SizedBox(
                height: 63,
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 155, 228, 250),
        child: const Icon(Icons.add),
      ),
    );
  }
}
