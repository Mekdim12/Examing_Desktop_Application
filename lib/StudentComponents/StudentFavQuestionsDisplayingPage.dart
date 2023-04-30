import 'package:diving_licence_traning_center_student/StudentComponents/StudentMainLandingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import '../Components/privillageChoosingPage.dart';
import '../Components/adminLandingPage.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import './QuestionTypeChoosingPage.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
import '../Models/StudentFavoriteModel.dart';
import 'dart:async';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import './studentTraningQuestionTestingPage.dart';
import 'StudentFavQuestionDetailViewPage.dart';

class StudentFavoriteFirstPageWidget extends StatefulWidget {
   StudentFavoriteFirstPageWidget(this.studentObject);

   Student studentObject;

  @override
  State<StudentFavoriteFirstPageWidget> createState() =>
      StudentFavoriteFirstPageState();
}

class StudentFavoriteFirstPageState extends State<StudentFavoriteFirstPageWidget> {
  
  @override
  Widget build(BuildContext context) {
    Student object = widget.studentObject;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body:  Container(
      constraints: const BoxConstraints.expand(),
      width: double.infinity,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.2, 0.9, 0.4],
        colors: [
          Color.fromRGBO(255, 239, 186, 1),
          Color.fromRGBO(255, 255, 255, 1),
          Color.fromRGBO(255, 255, 255, 1),
        ],
      )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black38),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return StudentMainLandingPageWidget(object);
                        }),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
              
            ],
          ),

      Expanded(child: 
          Column(
									children: [
										Container(
											margin: EdgeInsets.symmetric(vertical: 50),
											child: const Text(
												"Favorite Questions",
												style: TextStyle(
														fontFamily: 'quickSand',
														decoration: TextDecoration.underline,
														color: Colors.black,
														fontWeight: FontWeight.bold,
														fontSize: 22),
											),
										),
                   Expanded(child: ListItemBuilderWidget(1, object, '4'),),
									],
								)),
          
        ],
      ),
      
    )
    );
  }
}



class ListItemBuilderWidget extends StatefulWidget {
	const ListItemBuilderWidget(this.flag, this.studentObject,this.questionType, {super.key});

	final int flag;

  
  final String questionType;
  final Student studentObject;

	@override
	State<ListItemBuilderWidget> createState() => _ListItemBuilderState();
}

class _ListItemBuilderState extends State<ListItemBuilderWidget> {
	int indexOfHovered = 0;
	bool isContainerHovered = false;
	bool isDeleteButtonPressed = false;
	bool isDeleteHover = false;

  List type_of_question = ['ሞተርሳይክል',
							'አዉቶሞቢል',
							'ታክሲ 1',
							'ታክሲ 2',
							'ደረቅ 1',
							'ደረቅ 2', 
							'ደረቅ 3',
							'ህዝብ 1',
							'ህዝብ 2'
							];

	String typeIdentifier(String currentQuestionkey){
	 
		Box<QuestionTypeModel> dbs = QuestionTypeBox.getAllTheQuestionsTypes();
		dbs.toMap().forEach((key, value) {
			if (value.question_type_items.keys.toList()[0].toString() == currentQuestionkey){
				currentQuestionkey = type_of_question[int.parse(value.question_type_items.values.toList()[0].toString())-1].toString();
			}
		});

		return currentQuestionkey;	
	}


	List<Question> listOfItemsDataBaseFetcher(int flag) {
		Box<Question> db = QuestionBox.getAllTheQuestions();
    List<Question> temporaryHolder = [];

		db.toMap().forEach((key, value) {
			if (value.exam_type == flag) {
				temporaryHolder.add(value);
			}
		});

		return temporaryHolder;
	}

	@override
	Widget build(BuildContext context) {
		int currentState = widget.flag;
    
    Student studentObject = widget.studentObject;
    String questionType = widget.questionType;
    // String flag_for_page = widget.flag_for_page;


    var QuestionsList = {};
  	Box<Question> db = QuestionBox.getAllTheQuestions();
		db.toMap().forEach((key, value) {
			 QuestionsList[key.toString()] = value;
      
		});

    
    List<Question> StudentFavorite = [];
    Box<StudentFavoriteTypeModel> favQuestions = StudentFavoriteTypeBox.getAllTheStudentFav();
    favQuestions.toMap().forEach((key, value) {
        if(value.studentFav.keys.first == studentObject.id_number){
            if( QuestionsList.keys.contains(value.studentFav.values.first.toString())){
                // this means the question is avail still
                QuestionsList.forEach((keys, values) {
                    if(keys.toString() == value.studentFav.values.first.toString()){
                         
                        StudentFavorite.add(values);
                        
                      }
                }); 
            }

        }
    });

	List<Question> value = StudentFavorite;

		
		if(value.length <=  0){
			return Center(
									child: Container(
										margin: EdgeInsets.only(bottom: 150),
										alignment: Alignment.center,
										child: const Text(
											"No Items Found In The Database",
											style: TextStyle(
													color: Colors.redAccent,
													fontFamily: 'quickSand',
													fontSize: 32,
													fontWeight: FontWeight.bold),
										),
									),
								);
		}else{
			if(value.isNotEmpty){
				if(value[0].question.isNotEmpty){

									return ValueListenableBuilder(
			
				valueListenable: QuestionBox.getAllTheQuestions().listenable(),
				
				builder: (context, box, child) {
					return (value.length > 0)
							? ListView.builder(
									itemCount: value.length,
									itemBuilder: (context, int index) => InkWell(
										onTap: () {
											Navigator.of(context).push(
												MaterialPageRoute(builder: (ctx) {
													return StudentFavoriteDetailPageWidget(studentObject,  value[index]);
												}),
											);
										},
										onHover: (val) {
											indexOfHovered = index;
											isContainerHovered = val;
											setState(() {
												isContainerHovered;
											});
										},
										child: Container(
											margin: const EdgeInsets.symmetric(vertical: 10),
											height: 80,
											child: Card(
												shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(18),
														side: const BorderSide(color: Colors.blueGrey)),
												borderOnForeground: true,
												elevation: 8,
												color: (isContainerHovered && indexOfHovered == index)
														? const Color.fromARGB(139, 255, 255, 255)
														: const Color.fromARGB(115, 255, 255, 255),
												margin: const EdgeInsets.symmetric(horizontal: 150),
												child: Row(
													children: [
														Container(
															width: 50,
															child: Column(
																mainAxisAlignment: MainAxisAlignment.center,
																children: [
																	Text( '${(index + 1).toString()}:',
																			style: const TextStyle(
																					color: Colors.black54,
																					fontWeight: FontWeight.bold,
																					fontSize: 22)),
																],
															),
														),
														Flexible(
															child: Column(
																mainAxisAlignment: MainAxisAlignment.center,
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Container(
																		child: Text(
																			maxLines: 2,
																			softWrap: true,
																			'${value[index]
																					.question
																					.values.toList()[0].toString()} ?',
																			style: const TextStyle(
																					color: Colors.black87,
																					fontWeight: FontWeight.bold,
																					fontSize: 16
                                          ),
																		),
																	),
																],
															),
														),
													],
												),
											),
										),
									),
								)
							: Center(
									child: Container(
										margin: EdgeInsets.only(bottom: 150),
										alignment: Alignment.center,
										child: const Text(
											"No Items Found In The Database",
											style: TextStyle(
													color: Colors.redAccent,
													fontFamily: 'quickSand',
													fontSize: 32,
													fontWeight: FontWeight.bold),
										),
									),
								);
				});
	
				}else{
					return Center(
							child: Container(
								margin: EdgeInsets.only(bottom: 150),
								alignment: Alignment.center,
								child: const Text(
									"No Items Found In The Database",
									style: TextStyle(
											color: Colors.redAccent,
											fontFamily: 'quickSand',
											fontSize: 32,
											fontWeight: FontWeight.bold),
								),
							),
						);
				}
			}else{
				return Center(
						child: Container(
							margin: EdgeInsets.only(bottom: 150),
							alignment: Alignment.center,
							child: const Text(
								"No Items Found In The Database",
								style: TextStyle(
										color: Colors.redAccent,
										fontFamily: 'quickSand',
										fontSize: 32,
										fontWeight: FontWeight.bold),
							),
						),
					);
			}
		}
		
		

	
	}
}
