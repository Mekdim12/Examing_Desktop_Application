import 'package:hive/hive.dart';

part 'ScoreModel.g.dart';


/*
  studentId,: [ dateAndTime, tottalQuestion, correctAnsCount, IncorrectAnsCount, passFail, isFinished/status]
*/

@HiveType(typeId: 4)
class StudentScoreModel extends HiveObject {
  @HiveField(0)
  
  late Map<String, List> studentScore;
  
  StudentScoreModel(this.studentScore);

}



class StudentScoreBox {
  static Box<StudentScoreModel> getAllStudentsScore() =>
      Hive.box<StudentScoreModel>('StudentScoreMain');
}



