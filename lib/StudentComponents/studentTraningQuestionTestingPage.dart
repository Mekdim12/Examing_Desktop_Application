import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import './sideBarDrawer.dart';
import '../Models/QuestionModel.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import './QuestionTypeChoosingPage.dart';
import './studentTraningQuestionTestingPage.dart';
import 'package:hive/hive.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import 'package:hive/hive.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import './QuestionTypeChoosingPage.dart';
import './studentTraningQuestionTestingPage.dart';

class StudentQuestionTypeSpecificTestingPageWidget extends StatefulWidget {
  StudentQuestionTypeSpecificTestingPageWidget(this.studentObject, this.flag_for_page, this.questionType, this.questionIndex, {super.key});

    String flag_for_page; // menu identifier
	int questionIndex; // for displaying the question and marking active on sidebar
    String questionType; // 1-9 question type
    Student studentObject; // student info tracking

  @override
  State<StudentQuestionTypeSpecificTestingPageWidget> createState() => StudentQuestionTypeSpecificTestingPageState();
}

class StudentQuestionTypeSpecificTestingPageState extends State<StudentQuestionTypeSpecificTestingPageWidget> {
  @override
  Widget build(BuildContext context) {

	Student object = widget.studentObject;
	String flag_for_page = widget.flag_for_page;
	String questionType = widget.questionType;
	int questionIndex = widget.questionIndex;

	List questionTypeItems = ['ሞተርሳይክል',
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
		
        drawer:  StudentPageSidebarDrawerWidget(object, flag_for_page, questionType, questionIndex),
        appBar: AppBar(
          foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
          backgroundColor: Color.fromARGB(255, 96, 125, 139),
          title: const Text(
            'ፈተና መለማመጃ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
         
        ),
        body:  Container(
          width: double.infinity,
          height: double.infinity,
          // color: const Color(0xFFF5EBE0),
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
							image: AssetImage('assets/images/texturebackground.jpg'),
						),
						borderRadius: BorderRadius.circular(25)
					),
					margin: const EdgeInsets.only(bottom: 10, left: 100, right:100, top:35 ),
					// width: 1800,
					height: 650,
					child: Card(
						shadowColor: Colors.black,
						color: Color.fromARGB(76, 233, 233, 234),
						borderOnForeground: true,
						semanticContainer: true,
          				clipBehavior: Clip.antiAliasWithSaveLayer,
						elevation:1000,
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
											color: Color.fromARGB(181, 33, 45, 51), width: 2),
										borderRadius: BorderRadius.circular(25),
										shape: BoxShape.rectangle,
									),
									),
									Positioned(
									left: 1250,
									top: -8,
									child: Container(
										padding: EdgeInsets.only(bottom: 0, left: 10, right: 10, top: 10),
										decoration: BoxDecoration(
												color: Color.fromARGB(255, 33, 45, 51),
												borderRadius: BorderRadius.circular(15),
										),
										child: Text(
										'${questionTypeItems[int.parse(questionType)  - 1 ] }\t\t\t\t\t\t\t\tየሙከራ ጥያቄዎች',
										style: TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'quickSand'),
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
															color: Color.fromARGB(255, 51, 204, 255), width: 1),
														borderRadius: BorderRadius.circular(5),
														shape: BoxShape.rectangle,
													),
													),
													Positioned(
													left: 40,
													top: 5,
													child: Container(
														decoration: BoxDecoration(
															color: Color.fromARGB(255, 51, 204, 255),
															borderRadius: BorderRadius.circular(15)
														),
														padding: EdgeInsets.only(bottom: 10, left: 15, right: 15, top:5),
														 
														child: Text(
															'ጥያቄ ቁ.    1 ',
															style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
														),
													  ),
													),
 
        
												Container(
														margin: EdgeInsets.symmetric(vertical: 30, horizontal: 35),
														padding: EdgeInsets.only(top:15,bottom: 5),
														height: 160,
														child:SingleChildScrollView(
															scrollDirection: Axis.vertical,
															child:Text('QuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestion nuQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionmber one ?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color:Colors.black),),	
																						)),

												Column(

												mainAxisAlignment: MainAxisAlignment.end,
												children : [SingleChildScrollView(
													physics: NeverScrollableScrollPhysics(),
													child:
												 Container(
													child: 
													Column(
														
														 children: [
															
															Column(
															 children: [
																Container(
																	
																	child:Row(
																	mainAxisAlignment: MainAxisAlignment.spaceEvenly,
																	children: [
																		Container(
																		height: 160,
																		width: 650,
																		child: TextButton(
																			onPressed: (){},
																			child: Container(
																			width: 650,
																			height: 160,
																			child: Column(
																				mainAxisAlignment: MainAxisAlignment.center,
																				children: [
																				Row(
																					children : [
																						Container(
																						margin: EdgeInsets.symmetric(horizontal: 10),
																						alignment: Alignment.center,
																						width:50,
																						height: 50,
																						decoration: BoxDecoration(
																							color: Colors.blueGrey,
																							borderRadius: BorderRadius.circular(50)
																						),
																						padding: EdgeInsets.all(5),
																						child: Text('A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),),),

																						Container(
																							alignment: Alignment.topLeft,
																							margin: EdgeInsets.symmetric(horizontal:5 ),
																							padding: EdgeInsets.only(top:10, bottom: 10, left:15, right: 5),
																						width: 550,
																						height: 160,
																						child: SingleChildScrollView(
																								scrollDirection: Axis.vertical,
																								child:Text('Question nuQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionmber one ?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color:Colors.black),),	
																						),
																						decoration: BoxDecoration(
																							color: Color.fromARGB(95, 180, 180, 216),
																							borderRadius: BorderRadius.circular(10),
																							border: Border.all(color: Colors.black38),
																						),),

																					]
																				)
																				],
																			),
																			))
																		),
																	
																		Container(
																		height: 160,
																		width: 650,
																		child: TextButton(
																			onPressed: (){},
																			child: Container(
																			width: 650,
																			height: 160,
																			child: Column(
																				mainAxisAlignment: MainAxisAlignment.center,
																				children: [
																				Row(
																					children : [
																						Container(
																						margin: EdgeInsets.symmetric(horizontal: 10),
																						alignment: Alignment.center,
																						width:50,
																						height: 50,
																						decoration: BoxDecoration(
																							color: Colors.blueGrey,
																							borderRadius: BorderRadius.circular(50)
																						),
																						padding: EdgeInsets.all(5),
																						child: Text('C', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),),),

																						Container(
																							alignment: Alignment.topLeft,
																							margin: EdgeInsets.symmetric(horizontal:5 ),
																							padding: EdgeInsets.only(top:10, bottom: 10, left:15, right: 5),
																						width: 550,
																						height: 160,
																						child: Container(
																							alignment: Alignment.center,
																							child: Image.file(
																								fit: BoxFit.contain,
																								File(
																									"./CopiedFileAssets/1285073929.jpg")),
																							),
																						decoration: BoxDecoration(
																							color: Color.fromARGB(95, 180, 180, 216),
																							borderRadius: BorderRadius.circular(10),
																							border: Border.all(color: Colors.black38),
																						),),

																					]
																				)
																				],
																			),
																			))
																		),
																	
																	]
																),
															),

															

														] ),
													          

													Container(margin: EdgeInsets.symmetric(vertical: 15)),
											
												
														Container(
																height: 160,
																child:Column(
															 children: [
																Container(
																	
																	child:Row(
																	mainAxisAlignment: MainAxisAlignment.spaceEvenly,
																	children: [
																		Container(
																		height: 160,
																		width: 650,
																		child: TextButton(
																			onPressed: (){},
																			child: Container(
																			width: 650,
																			height: 160,
																			child: Column(
																				mainAxisAlignment: MainAxisAlignment.center,
																				children: [
																				Row(
																					children : [
																						Container(
																						margin: EdgeInsets.symmetric(horizontal: 10),
																						alignment: Alignment.center,
																						width:50,
																						height: 50,
																						decoration: BoxDecoration(
																							color: Colors.blueGrey,
																							borderRadius: BorderRadius.circular(50)
																						),
																						padding: EdgeInsets.all(5),
																						child: Text('B', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),),),

																						Container(
																							alignment: Alignment.topLeft,
																							margin: EdgeInsets.symmetric(horizontal:5 ),
																							padding: EdgeInsets.only(top:10, bottom: 10, left:15, right: 5),
																						width: 550,
																						height: 160,
																						child: SingleChildScrollView(
																								scrollDirection: Axis.vertical,
																								child:Text('Question number one ?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color:Colors.black),),	
																						),
																						decoration: BoxDecoration(
																							color: Color.fromARGB(95, 180, 180, 216),
																							borderRadius: BorderRadius.circular(10),
																							border: Border.all(color: Colors.black38),
																						),),

																					]
																				)
																				],
																			),
																			))
																		),
																	
																		Container(
																		height: 160,
																		width: 650,
																		child: TextButton(
																			onPressed: (){},
																			child: Container(
																			width: 650,
																			height: 160,
																			child: Column(
																				mainAxisAlignment: MainAxisAlignment.center,
																				children: [
																				Row(
																					children : [
																						Container(
																						margin: EdgeInsets.symmetric(horizontal: 10),
																						alignment: Alignment.center,
																						width:50,
																						height: 50,
																						decoration: BoxDecoration(
																							color: Colors.blueGrey,
																							borderRadius: BorderRadius.circular(50)
																						),
																						padding: EdgeInsets.all(5),
																						child: Text('D', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),),),

																						Container(
																							alignment: Alignment.topLeft,
																							margin: EdgeInsets.symmetric(horizontal:5 ),
																							padding: EdgeInsets.only(top:10, bottom: 10, left:15, right: 5),
																						width: 550,
																						height: 160,
																						child: Container(
																							alignment: Alignment.center,
																							child: Image.file(
																								fit: BoxFit.contain,
																								File(
																									"./CopiedFileAssets/1285073929.jpg")),
																							),
																						decoration: BoxDecoration(
																							color: Color.fromARGB(95, 180, 180, 216),
																							borderRadius: BorderRadius.circular(10),
																							border: Border.all(color: Colors.black38),
																						),),

																					]
																				)
																				],
																			),
																			))
																		),
																	
																	]
																),
															),

															

														],

													
														
														 ),
													      
														) ,



															Container(margin: EdgeInsets.symmetric(vertical: 15)),			
														],



													
													) ,
												)
												
												)

												])
												// 	Container(
												// 		height: 180,
												// 		// color: Colors.deepPurpleAccent,
												// 		margin: EdgeInsets.symmetric(vertical: 140, horizontal: 35),
												// 		child:Column(
												// 			children: [
												// 				Container(
												// 					color: Colors.cyan,
												// 					margin: EdgeInsets.only(top: 25),
												// 					child:Row(
												// 					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
												// 					children: [
												// 						Container(
												// 						height: 140,
												// 						width: 650,
												// 						child: TextButton(
												// 							onPressed: (){},
												// 							child: Container(
												// 							width: 650,
												// 							height: 140,
												// 							child: Column(
												// 								mainAxisAlignment: MainAxisAlignment.center,
												// 								children: [
												// 								Row(
												// 									children : [
												// 										Container(
												// 										margin: EdgeInsets.symmetric(horizontal: 10),
												// 										alignment: Alignment.center,
												// 										width:50,
												// 										height: 50,
												// 										decoration: BoxDecoration(
												// 											color: Colors.blueGrey,
												// 											borderRadius: BorderRadius.circular(50)
												// 										),
												// 										padding: EdgeInsets.all(5),
												// 										child: Text('A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),),),

												// 										Container(
												// 											alignment: Alignment.topLeft,
												// 											margin: EdgeInsets.symmetric(horizontal:5 ),
												// 											padding: EdgeInsets.only(top:10, bottom: 10, left:15, right: 5),
												// 										width: 550,
												// 										height: 140,
												// 										child: SingleChildScrollView(
												// 												scrollDirection: Axis.vertical,
												// 												child:Text('Question number one ?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color:Colors.black),),	
												// 										),
												// 										decoration: BoxDecoration(
												// 											color: Color.fromARGB(95, 180, 180, 216),
												// 											borderRadius: BorderRadius.circular(10),
												// 											border: Border.all(color: Colors.black38),
												// 										),),

												// 									]
												// 								)
												// 								],
												// 							),
												// 							))
												// 						),
																	
												// 						Container(
												// 						height: 140,
												// 						width: 650,
												// 						child: TextButton(
												// 							onPressed: (){},
												// 							child: Container(
												// 							width: 650,
												// 							height: 140,
												// 							child: Column(
												// 								mainAxisAlignment: MainAxisAlignment.center,
												// 								children: [
												// 								Row(
												// 									children : [
												// 										Container(
												// 										margin: EdgeInsets.symmetric(horizontal: 10),
												// 										alignment: Alignment.center,
												// 										width:50,
												// 										height: 50,
												// 										decoration: BoxDecoration(
												// 											color: Colors.blueGrey,
												// 											borderRadius: BorderRadius.circular(50)
												// 										),
												// 										padding: EdgeInsets.all(5),
												// 										child: Text('C', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),),),

												// 										Container(
												// 											alignment: Alignment.topLeft,
												// 											margin: EdgeInsets.symmetric(horizontal:5 ),
												// 											padding: EdgeInsets.only(top:10, bottom: 10, left:15, right: 5),
												// 										width: 550,
												// 										height: 140,
												// 										child: Container(
												// 											alignment: Alignment.center,
												// 											child: Image.file(
												// 												fit: BoxFit.contain,
												// 												// width: 400,
												// 												// height: 450,
												// 												File(
												// 													"./CopiedFileAssets/1285073929.jpg")),
												// 											),
												// 										decoration: BoxDecoration(
												// 											color: Color.fromARGB(95, 180, 180, 216),
												// 											borderRadius: BorderRadius.circular(10),
												// 											border: Border.all(color: Colors.black38),
												// 										),),

												// 									]
												// 								)
												// 								],
												// 							),
												// 							))
												// 						),
																	
												// 					]
												// 				),
												// 			),

															

												// 		]
												// 	),
												// ),


													























													
											

													],
												)
									)
								],
								)
							),
				),





































				Container(
					margin: EdgeInsets.only( left: 40, right:40, top:5 ),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: [
							Container(
								width: 500,
								height: 150,
								decoration:  BoxDecoration(
									borderRadius:BorderRadius.circular(20) ,
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
											border: Border.all(width: 1, color: Color.fromARGB(0, 96, 125, 139))
										),
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
													padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
													color: 	Color.fromRGBO(72, 85, 99, 1),
													child: Text(
													'የፈተና መረጃ',
													style: TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold),
													),
												),
												),
												Container(
													margin: EdgeInsets.only(left:50),
													child: Column(
														mainAxisAlignment: MainAxisAlignment.center,
														children: [
															Row( children: [
																Icon(Icons.not_interested, color:Colors.redAccent, size: 30,),
																Text('    የተሳስቱት ጥያቄ ብዛት  ፡ 0', style: TextStyle(color: Color.fromARGB(255, 211, 56, 56), fontSize: 18),)
															],),
															Container(margin: EdgeInsets.all(7),),
															Row( children: [
																Icon(Icons.assignment_turned_in, color: Colors.greenAccent, size: 25,),
																Text('    በትክክል የመለሱት ጥያቄ ብዛት  ፡ 0' , style: TextStyle(color: Colors.white, fontSize: 18),)
															],)
														],
													   )
													)
											],
											),)
							),
							Container(
								width: 500,
								height: 150,
								decoration:  BoxDecoration(
									borderRadius:BorderRadius.circular(20) ,
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
											border: Border.all(width: 1, color: Color.fromARGB(0, 96, 125, 139))
										),
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
													padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
													color: 	Color.fromRGBO(72, 85, 99, 1),
													child: Text(
													'ሰአት',
													style: TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold),
													),
												),
												),
												Container(
													// margin: EdgeInsets.only(left:50, top: 30),
													child: Column(
														mainAxisAlignment: MainAxisAlignment.center,
														children: [
															Row(
																mainAxisAlignment: MainAxisAlignment.center,
																children: [
																	Text('00', style: TextStyle(fontFamily: 'digital' ,color: Colors.greenAccent, fontSize:65, ),),
																	Text(':', style: TextStyle(fontFamily: 'digital' ,color: Colors.greenAccent, fontSize:65, ),),
																	Text('00', style: TextStyle(fontFamily: 'digital' ,color: Colors.greenAccent, fontSize:65, ),)
																],
															)
														],
													)
													
													)
											],
											),)
							),
							Container(
								width: 500,
								height: 150,
								decoration:  BoxDecoration(
									borderRadius:BorderRadius.circular(20) ,
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
											border: Border.all(width: 1, color: Color.fromARGB(0, 96, 125, 139))
										),
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
													padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
													color: 	Color.fromRGBO(72, 85, 99, 1),
													child: Text(
													'የተማሪው መረጃ',
													style: TextStyle(color: Colors.greenAccent, fontSize: 17, fontWeight: FontWeight.bold),
													),
												),
												),
												Container(
													margin: EdgeInsets.only(left:50),
													child: Column(
														mainAxisAlignment: MainAxisAlignment.center,
														children: [
															Row( mainAxisAlignment: MainAxisAlignment.start,
															children: [
																Container(
																	
																	width: 70,
																	height: 70,
																	decoration:  BoxDecoration(
																		border: Border.all(),
																		 shape: BoxShape.circle,
																		image: DecorationImage(image:  NetworkImage('https://img.icons8.com/fluency/96/null/person-male.png'))
																	),
																	
																),
																Container( margin: EdgeInsets.symmetric(horizontal: 15),),
																Row(
																	children: [
																		Container( child: Text('የተማሪው ኮድ ፡', style: TextStyle(color: Colors.greenAccent, fontSize: 17, fontWeight: FontWeight.bold),)),
																		Container(margin: EdgeInsets.symmetric(horizontal: 3),),
																		Container( child: Text(' XXXX ኮድ ፡', style: TextStyle(color: Colors.redAccent, fontSize: 17, fontWeight: FontWeight.bold),)),
																	]
																)
																
															],
															)
														],
													),
													)

											],
											),)
							),
						],
					) ,
				)
				

		  
			],
		  )
        ),
      ),
  
	);
  }
}





















/*
Container(
                                      alignment: Alignment.center,
                                      child: Image.file(
                                          fit: BoxFit.contain,
                                          width: 400,
                                          height: 250,
                                          File(
                                              "$cwd\\CopiedFileAssets\\${currentQuestion.question.values.toList()[0].toString()}")),
                                    )











	 Container(
                      margin: const EdgeInsets.only(top: 25),
                      width: 1650,
                      height: 800,
                      child: Column(
                        children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      width: 1650,
                      height: 750,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
																	'${questionTypeItems[int.parse(questionType)  - 1 ] }',
																	style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),),
                                  Container(margin: EdgeInsets.symmetric(horizontal: 10),),
                                  Container(child: Text('የሙከራ ጥያቄ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),),)
                              ],
                            )
                          ),
                          Container(
                            width: 1650,
                            height: 700,
                            child: Card(
                              color: Color.fromARGB(29, 96, 125, 139),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 20,
                              shadowColor: Color.fromRGBO(255, 239, 186, 1),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 100 ),
                                      height: 50,
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(child: Text("00", style: TextStyle(fontFamily: 'digital', fontWeight: FontWeight.bold, fontSize: 50,color: Colors.teal),),),
                                          Container(child: Text(":", style: TextStyle(fontFamily: 'digital',fontWeight: FontWeight.bold, fontSize: 30,color: Colors.blue),),),
                                          Container(child: Text("00", style: TextStyle(fontFamily: 'digital',fontWeight: FontWeight.bold, fontSize: 50,color: Colors.teal),),)
                                        ],
                                      ),
                                    ),
                                    
                                    Container(
                                      width: 1650,
                                      decoration:BoxDecoration(
                                        //  color:Colors.white38,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      height: 150,
                                     
                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                      child:Row(
                                        children: [
                                            Container(
                                              height: 150,
                                               
                                              padding: EdgeInsets.zero,
                                              margin: EdgeInsets.zero,
                                              child:Column(  
                                                  children: [
                                                    Container(
                                                      
                                                      decoration: BoxDecoration(
                                                        color:Colors.white54,
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15))
                                                    ),
                                                      height: 75,
                                                      width: 150,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                             Text('1.',style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold, fontSize: 35),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    Container(
                                                      height:75,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('ጥያቄ ቁ',style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 14),)],
                                                    ),
                                                      
                                                    ),
                                                  ],
                                              ),

                                          ),
                                        
                                           Container(
                                            margin: EdgeInsets.symmetric(horizontal: 1),
                                             
                                              padding: EdgeInsets.all(15),
                                              height:150,
                                              width: 1400,
                                              decoration: BoxDecoration(
                                                color:Colors.white38,
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight:   Radius.circular(15))
                                              ),
                                              child: SingleChildScrollView(child:Text('some', style: TextStyle(fontSize: 22, fontFamily: 'openSans', fontWeight: FontWeight.bold, color: Colors.black),),),
                                            )
                                        ],
                                      ),
                                    ),


                                    Container(
                                      child:Column(
                                          children: [
                                             Container(
                                                margin: EdgeInsets.symmetric(vertical: 25),
                                                child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                        Container(
                                                          height: 150,
                                                          width: 650,
                                                          // color:Colors.red,
                                                          child: TextButton(
                                                            onPressed: (){},
                                                            child: Container(
                                                              width: 650,
                                                              height: 150,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                      children : [
                                                                        Container(
                                                                          margin: EdgeInsets.symmetric(horizontal: 10),
                                                                          alignment: Alignment.center,
                                                                          width:50,
                                                                          height: 50,
                                                                          decoration: BoxDecoration(
                                                                            color: Color.fromRGBO(200, 104, 25, 1),
                                                                            borderRadius: BorderRadius.circular(50)
                                                                          ),
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Text('A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),

                                                                        Container(
                                                                           width: 550,
																		   height: 150,
																		   child: Text('ss'),
																		   decoration: BoxDecoration(
																			border: Border.all(),
																		   ),),

                                                                      ]
                                                                  )
                                                                ],
                                                              ),
                                                            ))
                                                        ),


                                                        Container(
                                                          height: 150,
                                                          width: 650,
                                                          color:Colors.yellow
                                                        ),
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 25),
                                                child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                        Container(
                                                          height: 150,
                                                          width: 650,
                                                          color:Colors.green
                                                        ),


                                                        Container(
                                                          height: 150,
                                                          width: 650,
                                                          color:Colors.blue
                                                        ),
                                                  ],
                                                ),
                                              )
                                          ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                          )
                        ],
                      )),
                      ],
                    ))
           

 */

/**
   Stack(
								children: <Widget>[
									Container(
									width: 1650,
									height: 750,
									margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
									padding: EdgeInsets.only(bottom: 10),
									decoration: BoxDecoration(
										border: Border.all(
											color: Colors.blueGrey, width: 2),
										borderRadius: BorderRadius.circular(15),
										shape: BoxShape.rectangle,
									),
									),
									Container(
												width: 1650,
												height: 700,
												child: Column(
													children: [
															Positioned(
																left: 50,
																top: 12,
																child:  Container(
																	padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
																	color:Color.fromRGBO(255, 239, 186, 0.751),
																	child: Text(
																	'${questionTypeItems[int.parse(questionType)  - 1 ] }',
																	style: TextStyle(color: Colors.black, fontSize: 20),
																	),
																),
															)

													],
												),
										)
									
								  ],
								)          
                      
 */