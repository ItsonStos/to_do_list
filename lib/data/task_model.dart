class TaskModel {
  final String id;
  final String task;
  final int difficult;
  final String image;

  const TaskModel({
    required this.id,
    required this.task,
    required this.difficult,
    required this.image,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map[kId],
      task: map[kTask],
      difficult: map[kDifficulty],
      image: map[kImage],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kId: id,
      kTask: task,
      kDifficulty: difficult,
      kImage: image,
    };
  }

  static const String kId = 'id';
  static const String kTask = 'name';
  static const String kDifficulty = 'difficulty';
  static const String kImage = 'image';
}
