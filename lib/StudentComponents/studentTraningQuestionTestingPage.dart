import 'package:flutter/material.dart';
import './sideBarDrawer.dart';
import '../Models/QuestionModel.dart';
import '../Models/StudentModels.dart';
import 'package:hive/hive.dart';
import 'dart:async';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'StudentQustionTtypeSpecficList.dart';
import '../Models/StudentFavoriteModel.dart';

bool is_a_choosed = false;
bool is_b_choosed = false;
bool is_c_choosed = false;
bool is_d_choosed = false;
bool isfavoriteQuesion = false;
final dbstudentfav = StudentFavoriteTypeBox.getAllTheStudentFav();
// Future<int> obj = db.add(question_object);

Timer? countdownTimer;
Duration myDuration = Duration(minutes: 2);
bool is_time_is_goingto_up = false;

class StudentQuestionTypeSpecificTestingPageWidget extends StatefulWidget {
  StudentQuestionTypeSpecificTestingPageWidget(this.studentObject,
	  this.flag_for_page, this.questionType, this.questionIndex,
	  {super.key});

  String flag_for_page; // menu identifier
  int questionIndex; // for displaying the question and marking active on sidebar
  String questionType; // 1-9 question type
  Student studentObject; // student info tracking

  @override
  State<StudentQuestionTypeSpecificTestingPageWidget> createState() =>
	  StudentQuestionTypeSpecificTestingPageState();
}

class StudentQuestionTypeSpecificTestingPageState
	extends State<StudentQuestionTypeSpecificTestingPageWidget> {
  Future openDialog(bool good_or_bad, Question? questionObject, List items) =>
	  showDialog(
		  context: context,
		  barrierDismissible: false,
		  builder: (context) => AlertDialog(
				actionsAlignment: MainAxisAlignment.center,
				buttonPadding: const EdgeInsets.all(5),
				contentPadding: const EdgeInsets.all(15),
				title: (good_or_bad)
					? const Text("መልሱን በትክክል መልሰዏል")
					: const Text("መልሱን ተሳስተዋል"),
				elevation: 8,
				icon: (good_or_bad)
					? const Icon(
						Icons.gpp_good,
						weight: 50,
						size: 50,
					  )
					: const Icon(
						Icons.gpp_bad,
						weight: 50,
						size: 50,
					  ),
				iconColor:
					(good_or_bad) ? Colors.greenAccent : Colors.redAccent,
				// backgroundColor: Color.fromARGB(225, 241, 237, 237),
				contentTextStyle: const TextStyle(
					color: Color.fromARGB(255, 25, 57, 42),
					fontWeight: FontWeight.bold),
				content: Container(
				  alignment: Alignment.center,
				  width: 150,
				  height: 150,
				  padding:
					  const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
				  child: Text(
					textAlign: TextAlign.center,
					(good_or_bad)
						? "የመረጡት ምርጫ ትክክለኛ ምላሽ ነው"
						: "የመረጡት ምርጫ ስህተት ነው ለዚህ ጥያቄ ትክክለኛ ምላሽ ሚሆነው ምርጫ ${questionObject?.correct_answer} ነው ሚሆነው ",
				  ),
				),

				actions: [
				  ElevatedButton.icon(
					  style: ButtonStyle(
						  padding: const MaterialStatePropertyAll(
							  EdgeInsets.symmetric(
								  vertical: 18, horizontal: 20)),
						  iconColor: MaterialStatePropertyAll(Colors.black),
						  backgroundColor: MaterialStatePropertyAll(
							  (good_or_bad)
								  ? Colors.greenAccent
								  : Colors.redAccent)),
					  onPressed: () {
						TimeCounterWidget(
							items[0], items[1], items[2], items[3]);
						setState(() {
						  countdownTimer!.cancel();
						  myDuration = Duration(minutes: 2);
						  is_time_is_goingto_up = false;
						});

						Navigator.of(context).pop();
					  },
					  icon: const Icon(Icons.close),
					  label: Text(
						"ተመለስ",
						style: TextStyle(
							color: Colors.black, fontWeight: FontWeight.bold),
					  ))
				],
			  ));

  @override
  Widget build(BuildContext context) {
	is_a_choosed = false;
	is_b_choosed = false;
	is_c_choosed = false;
	is_d_choosed = false;
	isfavoriteQuesion = false;

	Student object = widget.studentObject;
	String flag_for_page = widget.flag_for_page;
	String questionType = widget.questionType;
	int questionIndex = widget.questionIndex;
	String cwd = Hive.box('CurrenWorkingDirectory').get('cwd').toString();
	Box<Question> all_the_question = QuestionBox.getAllTheQuestions();

	Question? current_selected_question_object;
	all_the_question.toMap().forEach((key, value) {
	  if (key == questionIndex) {
		current_selected_question_object = value;
	  }
	});


	
	dbstudentfav.toMap().forEach((key, value) {
		
	  if (object.id_number == value.studentFav.keys.first.toString()) {
		String questionIndexfromfav = value.studentFav.values.first.toString(); // question Index
		if (questionIndex.toString() == questionIndexfromfav) {
			isfavoriteQuesion = true;
		}
	  }
	});

	
	List questionTypeItems = [
	  'ሞተርሳይክል',
	  'አዉቶሞቢል',
	  'ታክሲ 1',
	  'ታክሲ 2',
	  'ደረቅ 1',
	  'ደረቅ 2',
	  'ደረቅ 3',
	  'ህዝብ 1',
	  'ህዝብ 2'
	];

	return Container(
	  margin: EdgeInsets.zero,
	  padding: EdgeInsets.zero,
	  child: Scaffold(
		onDrawerChanged: (val) {
		  if (val) {
			TimeCounterWidget(
				object, flag_for_page, questionType, questionIndex);
			setState(() {
			  countdownTimer!.cancel();
			  myDuration = Duration(minutes: 2);
			  is_time_is_goingto_up = false;
			});
		  }
		},
		drawer: StudentPageSidebarDrawerWidget(
			object, flag_for_page, questionType, questionIndex),
		appBar: AppBar(
		  foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
		  backgroundColor: Color.fromARGB(255, 96, 125, 139),
		  title: const Text(
			'ፈተና መለማመጃ',
			style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
		  ),
		  centerTitle: true,
		  actions: [
			Container(
				margin: EdgeInsets.symmetric(horizontal: 30),
				child: IconButton(
					onPressed: () async{
						int positionIndex = 0;
						int index = 0;
						dbstudentfav.toMap().forEach((key, value) {
							if (object.id_number == value.studentFav.keys.first.toString()) {
								String questionIndexfromfav = value.studentFav.values.first.toString(); // question Index
								if (questionIndex.toString() == questionIndexfromfav) {
									isfavoriteQuesion = true;
									index = positionIndex;
								}
							}
								positionIndex += 1;	
						});


							
								StudentFavoriteTypeModel studentFav = StudentFavoriteTypeModel({object.id_number.toString(): questionIndex.toString()});
								if(! isfavoriteQuesion){
										await dbstudentfav.add(studentFav);
										
										isfavoriteQuesion = true;
								}else{
									await dbstudentfav.deleteAt(index);
									isfavoriteQuesion = false;
								}
							
							setState(() {
								isfavoriteQuesion;
							});
						},
					icon: Icon(
					  (!isfavoriteQuesion)
						  ? Icons.new_label_rounded
						  : Icons.label_off,
					  color:
						  (!isfavoriteQuesion) ? Colors.greenAccent : Colors.redAccent,
					  size: 45,
					)))
		  ],
		),
		body: Container(
			width: double.infinity,
			height: double.infinity,
			decoration: const BoxDecoration(
				gradient: LinearGradient(
			  begin: Alignment.centerLeft,
			  end: Alignment.centerRight,
			  stops: [0.2, 0.9, 0.4],
			  colors: [
				Color.fromRGBO(255, 239, 186, 0.5),
				Color.fromRGBO(255, 255, 255, 1),
				Color.fromRGBO(255, 255, 255, 1),
			  ],
			)),
			child: Column(
			  children: [
				Container(
				  decoration: BoxDecoration(
					  image: const DecorationImage(
						fit: BoxFit.cover,
						image:
							AssetImage('assets/images/texturebackground.jpg'),
					  ),
					  borderRadius: BorderRadius.circular(25)),
				  margin: const EdgeInsets.only(
					  bottom: 10, left: 100, right: 100, top: 5),
				  height: 650,
				  child: Card(
					  shadowColor: Colors.black,
					  color: Color.fromARGB(76, 233, 233, 234),
					  borderOnForeground: true,
					  semanticContainer: true,
					  clipBehavior: Clip.antiAliasWithSaveLayer,
					  elevation: 1000,
					  shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(25.0),
					  ),
					  child: Stack(
						children: <Widget>[
						  Container(
							width: double.infinity,
							margin: EdgeInsets.fromLTRB(1, 5, 1, 1),
							padding: EdgeInsets.only(bottom: 10),
							decoration: BoxDecoration(
							  border: Border.all(
								  color: Color.fromARGB(181, 33, 45, 51),
								  width: 2),
							  borderRadius: BorderRadius.circular(25),
							  shape: BoxShape.rectangle,
							),
						  ),
						  Positioned(
							left: 1050,
							top: -8,
							child: Container(
							  padding: EdgeInsets.only(
								  bottom: 0, left: 10, right: 10, top: 10),
							  decoration: BoxDecoration(
								color: Color.fromARGB(255, 33, 45, 51),
								borderRadius: BorderRadius.circular(15),
							  ),
							  child: Text(
								'${questionTypeItems[int.parse(questionType) - 1]}\t\t\t\t\t\t\t\tየሙከራ ጥያቄዎች',
								style: TextStyle(
									color: Colors.greenAccent,
									fontSize: 16,
									fontWeight: FontWeight.bold,
									fontFamily: 'quickSand'),
							  ),
							),
						  ),
						  Container(
							  width: double.infinity,
							  height: 650,
							  margin: EdgeInsets.only(top: 35, bottom: 10),
							  child: Stack(
								children: <Widget>[
								  Container(
									width: double.infinity,
									height: 170,
									margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
									padding: EdgeInsets.only(bottom: 10),
									decoration: BoxDecoration(
									  border: Border.all(
										  color:
											  Color.fromARGB(255, 51, 204, 255),
										  width: 1),
									  borderRadius: BorderRadius.circular(5),
									  shape: BoxShape.rectangle,
									),
								  ),
								  Positioned(
									left: 40,
									top: 5,
									child: Container(
									  decoration: BoxDecoration(
										  color:
											  Color.fromARGB(255, 51, 204, 255),
										  borderRadius:
											  BorderRadius.circular(15)),
									  padding: EdgeInsets.only(
										  bottom: 10,
										  left: 15,
										  right: 15,
										  top: 5),
									  child: Text(
										'ጥያቄ ቁ.    1 ',
										style: TextStyle(
											color: Colors.black,
											fontSize: 18,
											fontWeight: FontWeight.bold),
									  ),
									),
								  ),
								  Container(
									  alignment: Alignment.center,
									  margin: EdgeInsets.symmetric(
										  vertical: 30, horizontal: 35),
									  padding: EdgeInsets.only(
										  top:
											  (current_selected_question_object!
														  .question
														  .keys
														  .first ==
													  2)
												  ? 0
												  : 15,
										  bottom: 5),
									  height: 160,
									  child: SingleChildScrollView(
										scrollDirection: Axis.vertical,
										child:
											(current_selected_question_object!
														.question.keys.first ==
													1)
												? Text(
													textAlign: TextAlign.center,
													'${current_selected_question_object!.question.values.first}',
													style: TextStyle(
													  fontWeight:
														  FontWeight.bold,
													  fontSize: 20,
													  color: Colors.black,
													),
												  )
												: Container(
													alignment: Alignment.center,
													child: Image.file(
														fit: BoxFit.contain,
														width: 400,
														height: 150,
														File(
															'${cwd}\\CopiedFileAssets\\${current_selected_question_object!.question.values.first}')),
												  ),
									  )),
								  Column(
									  mainAxisAlignment: MainAxisAlignment.end,
									  children: [
										SingleChildScrollView(
											physics:
												NeverScrollableScrollPhysics(),
											child: Container(
											  child: Column(
												children: [
												  Column(children: [
													Container(
													  child: Row(
														  mainAxisAlignment:
															  MainAxisAlignment
																  .spaceEvenly,
														  children: [
															Container(
																height: 160,
																width: 650,
																child:
																	TextButton(
																		onPressed:
																			() {
																		  is_a_choosed =
																			  true;
																		  if ('A' ==
																			  current_selected_question_object?.correct_answer) {
																			openDialog(true,
																				current_selected_question_object, [
																			  object,
																			  flag_for_page,
																			  questionType,
																			  questionIndex
																			]);
																		  } else {
																			openDialog(false,
																				current_selected_question_object, [
																			  object,
																			  flag_for_page,
																			  questionType,
																			  questionIndex
																			]);
																		  }
																		},
																		child:
																			Container(
																		  width:
																			  650,
																		  height:
																			  160,
																		  child:
																			  Column(
																			mainAxisAlignment:
																				MainAxisAlignment.center,
																			children: [
																			  Row(children: [
																				Container(
																				  margin: EdgeInsets.symmetric(horizontal: 10),
																				  alignment: Alignment.center,
																				  width: 50,
																				  height: 50,
																				  decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(50)),
																				  padding: EdgeInsets.all(5),
																				  child: Text(
																					'A',
																					style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),
																				  ),
																				),
																				Container(
																				  alignment: Alignment.topLeft,
																				  margin: EdgeInsets.symmetric(horizontal: 5),
																				  padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
																				  width: 550,
																				  height: 160,
																				  child: SingleChildScrollView(
																					scrollDirection: Axis.vertical,
																					child: (current_selected_question_object?.list_choice[0].keys.first == 1)
																						? Text(
																							current_selected_question_object!.list_choice[0].values.first,
																							style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
																						  )
																						: Container(
																							alignment: Alignment.center,
																							child: Image.file(fit: BoxFit.contain, File('${cwd}\\CopiedFileAssets\\${current_selected_question_object!.list_choice[0].values.first}')),
																						  ),
																				  ),
																				  decoration: BoxDecoration(
																					color: Color.fromARGB(95, 180, 180, 216),
																					borderRadius: BorderRadius.circular(10),
																					border: Border.all(color: Colors.black38),
																				  ),
																				),
																			  ])
																			],
																		  ),
																		))),
															Container(
																height: 160,
																width: 650,
																child:
																	TextButton(
																		onPressed:
																			() {
																		  is_c_choosed =
																			  true;
																		  if ('C' ==
																			  current_selected_question_object?.correct_answer) {
																			openDialog(true,
																				current_selected_question_object, [
																			  object,
																			  flag_for_page,
																			  questionType,
																			  questionIndex
																			]);
																		  } else {
																			openDialog(false,
																				current_selected_question_object, [
																			  object,
																			  flag_for_page,
																			  questionType,
																			  questionIndex
																			]);
																		  }
																		},
																		child:
																			Container(
																		  width:
																			  650,
																		  height:
																			  160,
																		  child:
																			  Column(
																			mainAxisAlignment:
																				MainAxisAlignment.center,
																			children: [
																			  Row(children: [
																				Container(
																				  margin: EdgeInsets.symmetric(horizontal: 10),
																				  alignment: Alignment.center,
																				  width: 50,
																				  height: 50,
																				  decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(50)),
																				  padding: EdgeInsets.all(5),
																				  child: Text(
																					'C',
																					style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),
																				  ),
																				),
																				Container(
																				  alignment: Alignment.topLeft,
																				  margin: EdgeInsets.symmetric(horizontal: 5),
																				  padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
																				  width: 550,
																				  height: 160,
																				  child: SingleChildScrollView(
																					scrollDirection: Axis.vertical,
																					child: (current_selected_question_object?.list_choice[2].keys.first == 1)
																						? Text(
																							current_selected_question_object!.list_choice[2].values.first,
																							style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
																						  )
																						: Container(
																							alignment: Alignment.center,
																							child: Image.file(fit: BoxFit.contain, File('${cwd}\\CopiedFileAssets\\${current_selected_question_object!.list_choice[2].values.first}')),
																						  ),
																				  ),
																				  decoration: BoxDecoration(
																					color: Color.fromARGB(95, 180, 180, 216),
																					borderRadius: BorderRadius.circular(10),
																					border: Border.all(color: Colors.black38),
																				  ),
																				),
																			  ])
																			],
																		  ),
																		))),
														  ]),
													),
												  ]),
												  Container(
													  margin:
														  EdgeInsets.symmetric(
															  vertical: 15)),
												  Container(
													height: 160,
													child: Column(
													  children: [
														Container(
														  child: Row(
															  mainAxisAlignment:
																  MainAxisAlignment
																	  .spaceEvenly,
															  children: [
																Container(
																	height: 160,
																	width: 650,
																	child: TextButton(
																		onPressed: () {
																		  is_b_choosed =
																			  true;
																		  if ('B' ==
																			  current_selected_question_object?.correct_answer) {
																			openDialog(true,
																				current_selected_question_object, [
																			  object,
																			  flag_for_page,
																			  questionType,
																			  questionIndex
																			]);
																		  } else {
																			openDialog(false,
																				current_selected_question_object, [
																			  object,
																			  flag_for_page,
																			  questionType,
																			  questionIndex
																			]);
																		  }
																		},
																		child: Container(
																		  width:
																			  650,
																		  height:
																			  160,
																		  child:
																			  Column(
																			mainAxisAlignment:
																				MainAxisAlignment.center,
																			children: [
																			  Row(children: [
																				Container(
																				  margin: EdgeInsets.symmetric(horizontal: 10),
																				  alignment: Alignment.center,
																				  width: 50,
																				  height: 50,
																				  decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(50)),
																				  padding: EdgeInsets.all(5),
																				  child: Text(
																					'B',
																					style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),
																				  ),
																				),
																				Container(
																				  alignment: Alignment.topLeft,
																				  margin: EdgeInsets.symmetric(horizontal: 5),
																				  padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
																				  width: 550,
																				  height: 160,
																				  child: SingleChildScrollView(
																					scrollDirection: Axis.vertical,
																					child: (current_selected_question_object?.list_choice[1].keys.first == 1)
																						? Text(
																							current_selected_question_object!.list_choice[1].values.first,
																							style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
																						  )
																						: Container(
																							alignment: Alignment.center,
																							child: Image.file(fit: BoxFit.contain, File('${cwd}\\CopiedFileAssets\\${current_selected_question_object!.list_choice[1].values.first}')),
																						  ),
																				  ),
																				  decoration: BoxDecoration(
																					color: Color.fromARGB(95, 180, 180, 216),
																					borderRadius: BorderRadius.circular(10),
																					border: Border.all(color: Colors.black38),
																				  ),
																				),
																			  ])
																			],
																		  ),
																		))),
																Container(
																	height: 160,
																	width: 650,
																	child: TextButton(
																		onPressed: () {
																		  is_d_choosed =
																			  true;
																		  if ('D' ==
																			  current_selected_question_object?.correct_answer) {
																			openDialog(true,
																				current_selected_question_object, [
																			  object,
																			  flag_for_page,
																			  questionType,
																			  questionIndex
																			]);
																		  } else {
																			openDialog(false,
																				current_selected_question_object, [
																			  object,
																			  flag_for_page,
																			  questionType,
																			  questionIndex
																			]);
																		  }
																		},
																		child: Container(
																		  width:
																			  650,
																		  height:
																			  160,
																		  child:
																			  Column(
																			mainAxisAlignment:
																				MainAxisAlignment.center,
																			children: [
																			  Row(children: [
																				Container(
																				  margin: EdgeInsets.symmetric(horizontal: 10),
																				  alignment: Alignment.center,
																				  width: 50,
																				  height: 50,
																				  decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(50)),
																				  padding: EdgeInsets.all(5),
																				  child: Text(
																					'D',
																					style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),
																				  ),
																				),
																				Container(
																				  alignment: Alignment.topLeft,
																				  margin: EdgeInsets.symmetric(horizontal: 5),
																				  padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
																				  width: 550,
																				  height: 160,
																				  child: SingleChildScrollView(
																					scrollDirection: Axis.vertical,
																					child: (current_selected_question_object?.list_choice[3].keys.first == 1)
																						? Text(
																							current_selected_question_object!.list_choice[3].values.first,
																							style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
																						  )
																						: Container(
																							alignment: Alignment.center,
																							child: Image.file(fit: BoxFit.contain, File('${cwd}\\CopiedFileAssets\\${current_selected_question_object!.list_choice[3].values.first}')),
																						  ),
																				  ),
																				  decoration: BoxDecoration(
																					color: Color.fromARGB(95, 180, 180, 216),
																					borderRadius: BorderRadius.circular(10),
																					border: Border.all(color: Colors.black38),
																				  ),
																				),
																			  ])
																			],
																		  ),
																		))),
															  ]),
														),
													  ],
													),
												  ),
												  Container(
													  margin:
														  EdgeInsets.symmetric(
															  vertical: 15)),
												],
											  ),
											))
									  ])
								],
							  ))
						],
					  )),
				),
				Container(
				  margin: EdgeInsets.only(left: 40, right: 40, top: 5),
				  child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: [
					  Container(
						  width: 500,
						  height: 150,
						  decoration: BoxDecoration(
							  borderRadius: BorderRadius.circular(20),
							  gradient: LinearGradient(
								begin: Alignment.centerLeft,
								end: Alignment.centerRight,
								stops: [0.5, 0.9],
								colors: [
								  Color.fromRGBO(72, 85, 99, 1),
								  Color.fromRGBO(41, 50, 60, 1),
								],
							  )),
						  child: Container(
							decoration: BoxDecoration(
								border: Border.all(
									width: 1,
									color: Color.fromARGB(0, 96, 125, 139))),
							child: Stack(
							  children: <Widget>[
								Container(
								  width: double.infinity,
								  margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
								  padding: EdgeInsets.only(bottom: 10),
								  decoration: BoxDecoration(
									border: Border.all(
										color: Colors.greenAccent, width: 2),
									borderRadius: BorderRadius.circular(15),
									shape: BoxShape.rectangle,
								  ),
								),
								Positioned(
								  left: 50,
								  top: -12,
								  child: Container(
									padding: EdgeInsets.only(
										bottom: 10,
										left: 10,
										right: 10,
										top: 10),
									color: Color.fromRGBO(72, 85, 99, 1),
									child: Text(
									  'የፈተና መረጃ',
									  style: TextStyle(
										  color: Colors.greenAccent,
										  fontSize: 18,
										  fontWeight: FontWeight.bold),
									),
								  ),
								),
								Container(
									margin: EdgeInsets.only(left: 50),
									child: Column(
									  mainAxisAlignment:
										  MainAxisAlignment.center,
									  children: [
										Row(
										  children: [
											Icon(
											  Icons.not_interested,
											  color: Colors.redAccent,
											  size: 30,
											),
											Text(
											  '    የተሳስቱት ጥያቄ ብዛት  ፡ 0',
											  style: TextStyle(
												  color: Color.fromARGB(
													  255, 211, 56, 56),
												  fontSize: 18),
											)
										  ],
										),
										Container(
										  margin: EdgeInsets.all(7),
										),
										Row(
										  children: [
											Icon(
											  Icons.assignment_turned_in,
											  color: Colors.greenAccent,
											  size: 25,
											),
											Text(
											  '    በትክክል የመለሱት ጥያቄ ብዛት  ፡ 0',
											  style: TextStyle(
												  color: Colors.white,
												  fontSize: 18),
											)
										  ],
										)
									  ],
									))
							  ],
							),
						  )),
					  Container(
						  width: 500,
						  height: 150,
						  decoration: BoxDecoration(
							  borderRadius: BorderRadius.circular(20),
							  gradient: LinearGradient(
								begin: Alignment.centerLeft,
								end: Alignment.centerRight,
								stops: [0.5, 0.9],
								colors: [
								  Color.fromRGBO(72, 85, 99, 1),
								  Color.fromRGBO(41, 50, 60, 1),
								],
							  )),
						  child: Container(
							decoration: BoxDecoration(
								border: Border.all(
									width: 1,
									color: Color.fromARGB(0, 96, 125, 139))),
							child: Stack(
							  children: <Widget>[
								Container(
								  width: double.infinity,
								  margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
								  padding: EdgeInsets.only(bottom: 10),
								  decoration: BoxDecoration(
									border: Border.all(
										color: Colors.greenAccent, width: 2),
									borderRadius: BorderRadius.circular(15),
									shape: BoxShape.rectangle,
								  ),
								),
								Positioned(
								  left: 50,
								  top: -12,
								  child: Container(
									padding: EdgeInsets.only(
										bottom: 10,
										left: 10,
										right: 10,
										top: 10),
									color: Color.fromRGBO(72, 85, 99, 1),
									child: Text(
									  'ሰአት',
									  style: TextStyle(
										  color: Colors.greenAccent,
										  fontSize: 18,
										  fontWeight: FontWeight.bold),
									),
								  ),
								),
								TimeCounterWidget(object, flag_for_page,
									questionType, questionIndex)
							  ],
							),
						  )),
					  Container(
						  width: 500,
						  height: 150,
						  decoration: BoxDecoration(
							  borderRadius: BorderRadius.circular(20),
							  gradient: LinearGradient(
								begin: Alignment.centerLeft,
								end: Alignment.centerRight,
								stops: [0.5, 0.9],
								colors: [
								  Color.fromRGBO(72, 85, 99, 1),
								  Color.fromRGBO(41, 50, 60, 1),
								],
							  )),
						  child: Container(
							decoration: BoxDecoration(
								border: Border.all(
									width: 1,
									color: Color.fromARGB(0, 96, 125, 139))),
							child: Stack(
							  children: <Widget>[
								Container(
								  width: double.infinity,
								  margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
								  padding: EdgeInsets.only(bottom: 10),
								  decoration: BoxDecoration(
									border: Border.all(
										color: Colors.greenAccent, width: 2),
									borderRadius: BorderRadius.circular(15),
									shape: BoxShape.rectangle,
								  ),
								),
								Positioned(
								  left: 50,
								  top: -12,
								  child: Container(
									padding: EdgeInsets.only(
										bottom: 10,
										left: 10,
										right: 10,
										top: 10),
									color: Color.fromRGBO(72, 85, 99, 1),
									child: Text(
									  'የተማሪው መረጃ',
									  style: TextStyle(
										  color: Colors.greenAccent,
										  fontSize: 17,
										  fontWeight: FontWeight.bold),
									),
								  ),
								),
								Container(
								  margin: EdgeInsets.only(left: 50),
								  child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
									  Row(
										mainAxisAlignment:
											MainAxisAlignment.start,
										children: [
										  Container(
											width: 70,
											height: 70,
											decoration: BoxDecoration(
											  border: Border.all(),
											  shape: BoxShape.circle,
                        // image: AssetImage('assets/images/texturebackground.jpg')
											  image: DecorationImage(image:  AssetImage('assets/images/stud48.png'))
											),
										  ),
										  Container(
											margin: EdgeInsets.symmetric(
												horizontal: 15),
										  ),
										  Row(children: [
											Container(
												child: Text(
											  'የተማሪው ኮድ ፡',
											  style: TextStyle(
												  color: Colors.greenAccent,
												  fontSize: 17,
												  fontWeight: FontWeight.bold),
											)),
											Container(
											  margin: EdgeInsets.symmetric(
												  horizontal: 3),
											),
											Container(
												child: Text(
											  '${object.id_number.toString()}',
											  style: TextStyle(
												  color: Colors.redAccent,
												  fontSize: 17,
												  fontWeight: FontWeight.bold),
											)),
										  ])
										],
									  )
									],
								  ),
								)
							  ],
							),
						  )),
					],
				  ),
				)
			  ],
			)),
	  ),
	);
  }
}

class TimeCounterWidget extends StatefulWidget {
  TimeCounterWidget(this.studentObject, this.flag_for_page, this.questionType,
	  this.questionIndex,
	  {super.key});
  String flag_for_page; // menu identifier
  int questionIndex; // for displaying the question and marking active on sidebar
  String questionType; // 1-9 question type
  Student studentObject; // student info tracking

  @override
  State<TimeCounterWidget> createState() => TimeCounterState();
}

class TimeCounterState extends State<TimeCounterWidget> {
  void startTimer() {
	countdownTimer =
		Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  @override
  void initState() {
	startTimer();
	super.initState();
  }

  @override
  void setState(fn) {
	if (mounted) {
	  super.setState(fn);
	}
  }

  void setCountDown() {
	final reduceSecondsBy = 1;
	if (this.mounted) {
	  super.setState(() {
		final seconds = myDuration.inSeconds - reduceSecondsBy;
		if (seconds < 0) {
		  countdownTimer!.cancel();
		} else {
		  myDuration = Duration(seconds: seconds);
		}
	  });
	}
  }

  @override
  void dispose() {
	countdownTimer?.cancel();
	super.dispose();
  }

  Future openDialog() => showDialog(
	  context: context,
	  barrierDismissible: false,
	  builder: (context) => AlertDialog(
			actionsAlignment: MainAxisAlignment.center,
			buttonPadding: const EdgeInsets.all(5),
			contentPadding: const EdgeInsets.all(15),
			title: const Text("መልሱን ለመለመስ የተስጥዎት ግዜ አልቋል"),
			elevation: 8,
			icon: const Icon(
			  Icons.gpp_bad,
			  weight: 50,
			  size: 50,
			),
			iconColor: Colors.redAccent,
			// backgroundColor: Color.fromARGB(225, 241, 237, 237),
			contentTextStyle: const TextStyle(
				color: Color.fromARGB(255, 25, 57, 42),
				fontWeight: FontWeight.bold),
			content: Container(
			  alignment: Alignment.center,
			  width: 150,
			  height: 150,
			  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
			  child: Text(
				textAlign: TextAlign.center,
				"ይህን ጥያቄ ለመስራት ከተሰጥዎት 2 ደቂቃ ዉስጥ ጥያቄውን ሰርተው አልጨረሱም አብክዉዎን አንደገና ይምክሩ ",
			  ),
			),

			actions: [
			  ElevatedButton.icon(
				  style: ButtonStyle(
					  padding: const MaterialStatePropertyAll(
						  EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
					  iconColor: MaterialStatePropertyAll(Colors.black),
					  backgroundColor:
						  MaterialStatePropertyAll(Colors.redAccent)),
				  onPressed: () {
					Navigator.of(context).push(
					  MaterialPageRoute(builder: (ctx) {
						return StudentQuestionTypeSpecificTestingPageWidget(
							widget.studentObject,
							widget.flag_for_page,
							widget.questionType,
							widget.questionIndex);
					  }),
					);
				  },
				  icon: const Icon(Icons.close),
				  label: Text(
					"አንደጋና ይሞክሩ",
					style: TextStyle(
						color: Colors.black, fontWeight: FontWeight.bold),
				  )),
			  ElevatedButton.icon(
				  style: ButtonStyle(
					  padding: const MaterialStatePropertyAll(
						  EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
					  iconColor: MaterialStatePropertyAll(Colors.black),
					  backgroundColor:
						  MaterialStatePropertyAll(Colors.greenAccent)),
				  onPressed: () {
					Navigator.of(context).pushReplacement(
					  MaterialPageRoute(builder: (ctx) {
						return QuestionListDisplayPageWidget(
							widget.flag_for_page,
							widget.studentObject,
							widget.questionType);
					  }),
					);
				  },
				  icon: const Icon(Icons.close),
				  label: Text(
					"ወደ ጥያቄዎች ዝርዝር",
					style: TextStyle(
						color: Colors.black, fontWeight: FontWeight.bold),
				  ))
			],
		  ));

  @override
  Widget build(BuildContext context) {
	String strDigits(int n) => n.toString().padLeft(2, '0');

	final minutes = strDigits(myDuration.inMinutes.remainder(60));
	final seconds = strDigits(myDuration.inSeconds.remainder(60));

	if ((int.parse(minutes.trim()) == 0 && int.parse(seconds.trim()) <= 30)) {
	  is_time_is_goingto_up = true;
	}

	if ((int.parse(minutes.trim()) == 0 && int.parse(seconds.trim()) == 0) &&
		countdownTimer?.isActive == true) {
	  if (this.mounted) {
		setState(() {
		  countdownTimer!.cancel();
		  myDuration = Duration(minutes: 2);
		  is_time_is_goingto_up = false;
		});

		if (!(((is_a_choosed && is_b_choosed) & is_c_choosed) & is_d_choosed)) {
		  // WidgetsBinding.instance.addPersistentFrameCallback((x) {

		  Future.delayed(Duration.zero, () {
			openDialog();
		  });
		  // });
		}
	  }
	}

	return Container(
		child: Column(
	  mainAxisAlignment: MainAxisAlignment.center,
	  children: [
		Row(
		  mainAxisAlignment: MainAxisAlignment.center,
		  children: [
			Text(
			  '${minutes}',
			  style: TextStyle(
				fontFamily: 'digital',
				color: (is_time_is_goingto_up)
					? Colors.redAccent
					: Colors.greenAccent,
				fontSize: 65,
			  ),
			),
			Text(
			  ':',
			  style: TextStyle(
				fontFamily: 'digital',
				color: (is_time_is_goingto_up)
					? Colors.redAccent
					: Colors.greenAccent,
				fontSize: 65,
			  ),
			),
			Text(
			  '${seconds}',
			  style: TextStyle(
				fontFamily: 'digital',
				color: (is_time_is_goingto_up)
					? Colors.redAccent
					: Colors.greenAccent,
				fontSize: 65,
			  ),
			)
		  ],
		)
	  ],
	));
  }
}
