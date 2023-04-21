import 'package:hive/hive.dart';
part 'StudentFavoriteModel.g.dart';

/*

  student Id : questionId,
  1 : question Index
  1: 45
  1:25
  147:255
  
*/

@HiveType(typeId: 3)
class StudentFavoriteTypeModel extends HiveObject {
  @HiveField(0)
  late Map<String, String> studentFav;
  // studentId : QuestionIndex
  StudentFavoriteTypeModel(this.studentFav);

}


class StudentFavoriteTypeBox {
  static Box<StudentFavoriteTypeModel> getAllTheStudentFav() =>
      Hive.box<StudentFavoriteTypeModel>('StudentFavMain');
}





