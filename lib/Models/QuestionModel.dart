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

  Question.fromJson(Map<String, dynamic> json) {
    exam_type = json['Type'];
    question = json['Question'];
    list_choice = json['Choices'];
    correct_answer = json['CorretAnswer'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.exam_type;
    data['CorretAnswer'] = this.correct_answer;
    data['Question'] = this.question;

    data['Choices'] = this.list_choice;

    // print(data);
    return data;
  }
}

class QuestionBox {
  static Box<Question> getAllTheQuestions() =>
      Hive.box<Question>('QuestionInformatioModel_Trial4');
}
