import 'package:hive/hive.dart';
part 'QuestionTypeModel.g.dart';

@HiveType(typeId: 2)
class QuestionTypeModel extends HiveObject {
  @HiveField(0)
  late Map<String, String> question_type_items;
  // questionId : questionType
  QuestionTypeModel(this.question_type_items);

}

class QuestionTypeBox {
  static Box<QuestionTypeModel> getAllTheQuestionsTypes() =>
      Hive.box<QuestionTypeModel>('QuestionTypeMain');
}



