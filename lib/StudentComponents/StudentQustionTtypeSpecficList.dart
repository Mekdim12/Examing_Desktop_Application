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

class QuestionListDisplayPageWidget extends StatefulWidget {
	QuestionListDisplayPageWidget(this.flag_for_page, this.studentObject,this.questionType,{super.key});

	
	String flag_for_page;
	String questionType;
	Student studentObject;
  

	@override
	State<QuestionListDisplayPageWidget> createState() =>
			_QuestionListDisplayPageState();
}

class _QuestionListDisplayPageState extends State<QuestionListDisplayPageWidget> {
	@override
	Widget build(BuildContext context) {


		Student object = widget.studentObject;
		String flag_for_page = widget.flag_for_page;
		String questionType = widget.questionType;

	


		return Container(
			margin: EdgeInsets.zero,
			padding: EdgeInsets.zero,
			width: double.infinity,
			height: double.infinity,
			child: DefaultTabController(
				length: 2,
				child: Scaffold(
						appBar: AppBar(
							elevation: 5,
							toolbarOpacity: 0.2,
							bottom: const TabBar(
								indicatorColor: Color.fromRGBO(255, 239, 186, 1),
								dividerColor: Colors.white,
								labelColor: Colors.black,
								indicatorSize: TabBarIndicatorSize.tab,
								tabs: [
									Tab(
										text: "የጽሁፍ ፈተና",
										icon: Icon(
											
											Icons.abc,
											color: Color.fromRGBO(255, 239, 186, 1),
											size: 30,
										)),
									Tab(
										iconMargin: EdgeInsets.all(5),
										text: "የምስል ፈተና",
										icon: Icon(
											
											Icons.image,
											size: 30,
											color: Color.fromRGBO(255, 239, 186, 1),
										),
									)
								],
							),
							foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
							backgroundColor: Color.fromRGBO(161, 157, 157, 1),
							leadingWidth: 150,
							leading: Container(
								margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
								width: 150,
								height: 45,
								child: ElevatedButton(
									style: ButtonStyle(
									backgroundColor: MaterialStateProperty.all(Colors.green),
									),
									onPressed: () {
										Navigator.of(context).pushReplacement(
											MaterialPageRoute(builder: (ctx) {
												return QuestionTypeChossingPage(flag_for_page, object);
											}),
										);
									},
									child: Text(
									"ወደ ኋላ ተመለስ",
									style:
										TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
									)),
							),
							title: const Text(
								'የፈተናዎች ዝርዝር',
								style: TextStyle(
										color: Colors.black,
										fontFamily: 'quickSand',
										fontSize: 24,
										fontWeight: FontWeight.bold),
							),
							centerTitle: true,
						),
						body: TabBarView(children: [
							Container(
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
										Container(
											margin: EdgeInsets.symmetric(vertical: 50),
											child: const Text(
												"በጽሁፍ የሚገኙ ጥያቄዎች ዝርዝር",
												style: TextStyle(
														fontFamily: 'quickSand',
														decoration: TextDecoration.underline,
														color: Colors.black,
														fontWeight: FontWeight.bold,
														fontSize: 22),
											),
										),
										Expanded(child: ListItemBuilderWidget(1, object, questionType, flag_for_page)),
									],
								),
							),
							Container(
								constraints: const BoxConstraints.expand(),
								width: double.infinity,
								// height: double.infinity,
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
										Container(
											margin: EdgeInsets.symmetric(vertical: 50),
											child: const Text(
												"በምስል የሚገኙ ጥያቄዎች ዝርዝር",
												style: TextStyle(
													fontFamily: 'quickSand',
														decoration: TextDecoration.underline,
														color: Colors.black,
														fontWeight: FontWeight.bold,
														fontSize: 22),
											),
										),
										Expanded(child: ListItemBuilderWidget(2, object,questionType, flag_for_page)),
									],
								),
							),
						])),
			),
		);
	}
}

class ListItemBuilderWidget extends StatefulWidget {
	const ListItemBuilderWidget(this.flag, this.studentObject,this.questionType, this.flag_for_page, {super.key});

	final int flag;

  final String flag_for_page;
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
    String flag_for_page = widget.flag_for_page;
	

    
    List tempListOfQuestionkeys = [];
    List<Question> Questions = [];
	Box<Question> db = QuestionBox.getAllTheQuestions();
		db.toMap().forEach((key, value) {
			Questions.add(value);
        tempListOfQuestionkeys.add(value.key.toString());
		});

	List<QuestionTypeModel> tempvalue = [];
    Box<QuestionTypeModel> dbs = QuestionTypeBox.getAllTheQuestionsTypes();

    dbs.toMap().forEach((key, value) {
      if (value.question_type_items.values.toList()[0].toString() == questionType){
		
          if( tempListOfQuestionkeys.contains(value.question_type_items.keys.toList()[0].toString())){
             tempvalue.add(value);
          }
         
        }
    });

	List<Question> value = [];
	Questions.forEach((val) {	
		tempvalue.forEach((element) {
			if(element.question_type_items.keys.toList()[0].toString() == val.key.toString()){
				if(currentState.toString() == val.exam_type.toString()){
					value.add(val);
				}
				
			}	
		});		
	});

	
		
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
													return StudentQuestionTypeSpecificTestingPageWidget(studentObject, flag_for_page, questionType, value[index].key);
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
																					color: Colors.black54
																					,
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
																					.values.toList()[0].toString()} ?'
																					,
																			style: const TextStyle(
																					color: Colors.black87
																					 ,
																					fontWeight: FontWeight.bold,
																					fontSize: 16),
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
