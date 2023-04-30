import 'package:hive/hive.dart';

// part 'QuestionTypeModel.g.dart';


/*
  studentId,: [ dateAndTime, tottalQuestion, correctAnsCount, IncorrectAnsCount, passFail, isFinished/status]

*/
@HiveType(typeId: 4)
class StudentScoreModel extends HiveObject {
  @HiveField(0)
  late Map<String, List> question_type_items;
  //questionId : questionType
  StudentScoreModel(this.question_type_items);

}



