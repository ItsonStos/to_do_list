import 'package:flutter/material.dart';
import 'package:to_do_list/components/color_container_widget.dart';
import 'package:to_do_list/components/difficulty_widget.dart';
import 'package:to_do_list/data/task_dao.dart';
import 'package:to_do_list/data/task_model.dart';
import 'package:to_do_list/library/util.dart';

class TaskTile extends StatefulWidget {
  final TaskModel taskDao;
  const TaskTile(this.taskDao, {super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  int nivel = 0;
  void levelUp() {
    setState(() {
      nivel++;
    });
  }

  bool assetOrNetwork() {
    if (['http', 'https'].contains(widget.taskDao.image)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ColorContainnerWidget(nivel, widget.taskDao.difficult),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.5),
                        color: Colors.black12,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.taskDao.image.trim().isNotEmpty ? widget.taskDao.image : Util.assetsPlaceHolder,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.taskDao.image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.taskDao.task,
                              style: const TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DifficultyWidget(widget.taskDao.difficult),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                        onLongPress: () {
                          TaskDao().delete(widget.taskDao.task);
                        },
                        onPressed: () {
                          setState(() {
                            nivel++;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Icon(Icons.arrow_drop_up),
                            const Text(
                              'Lvl Up',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          value: widget.taskDao.difficult > 0 ? (nivel / widget.taskDao.difficult) / 10 : nivel / 10,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      (nivel / widget.taskDao.difficult) <= 50 ? 'Nivel: $nivel' : 'Nivel Mestre',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
