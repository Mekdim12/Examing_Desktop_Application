import 'package:hive/hive.dart';
part 'QuestionModel.g.dart';

@HiveType(typeId: 0)
class Question extends HiveObject {
  @HiveField(0)
  late int exam_type;

  @HiveField(1)
  late Map<int, String> question;

  @HiveField(2)
  late List<Map<int, String>> list_choice;

  @HiveField(3)
  late String correct_answer;

  Question(
      this.exam_type, this.question, this.list_choice, this.correct_answer);
}

class QuestionBox {
  static Box<Question> getAllTheQuestions() =>
      Hive.box<Question>('QuestionInformatioModel');
}
