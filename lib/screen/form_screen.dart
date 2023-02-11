import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:to_do_list/components/task.dart';
import 'package:to_do_list/data/database.dart';

class FormScreen extends StatefulWidget {
  
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController taskController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  double difficultyLevel= 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: taskController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.task, color: Colors.blue,),
                labelText: 'Tarefa',
                hintText: 'Nome',

              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.perm_device_info_outlined, color: Colors.blue),
                    const SizedBox(width: 12,),
                    RatingBar.builder(
                      minRating: 1,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: ((context, index) => const Icon(Icons.star, color: Colors.blueAccent,)),
                      onRatingUpdate: (difficultyLevel) => setState(() {
                        this.difficultyLevel = difficultyLevel;
                      }),
                    ),
                  ],
                ),            
                Text('Dificuldade: ${difficultyLevel.toInt()}'),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(
                icon: Icon(Icons.image, color: Colors.blue),
                labelText: 'Imagem',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {
              CreatTableTask().save(Task(
                taskController.text, 
                imageController.text, 
                difficultyLevel.toInt(),
                ));
                //print(taskController.text);
                //print(imageController.text);
                //print(difficultyLevel);
                Navigator.pop(context);
            }, 
            child: const Text('Salvar Tarefas')),
          ],
        ),
      ),
    );
  }
}
