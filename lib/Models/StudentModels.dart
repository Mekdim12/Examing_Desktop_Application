import 'package:hive/hive.dart';
part 'StudentModels.g.dart';

@HiveType(typeId: 1)
class Student extends HiveObject {
  @HiveField(0)
  late String fullName;

  @HiveField(1)
  late String id_number;

  @HiveField(2)
  late String password;

  
  Student(
      this.fullName, this.id_number, this.password);

}


class StudentBox {
  static Box<Student> getAllTheStudentsInfo() =>Hive.box<Student>('StudentInformationMain');
}