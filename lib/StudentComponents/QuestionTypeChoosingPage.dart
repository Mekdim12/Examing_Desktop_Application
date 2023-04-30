import 'dart:math';
import 'package:diving_licence_traning_center_student/StudentComponents/StudentMainLandingPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Models/StudentModels.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import './StudentQustionTtypeSpecficList.dart';
import './StudetnMainExamTakingPage.dart';
class QuestionTypeChossingPage extends StatefulWidget {
	String flag_for_page;
  Student studentObject;

   QuestionTypeChossingPage(this.flag_for_page, this.studentObject);
   

  @override
  State<QuestionTypeChossingPage> createState() =>
      QuestionChosingPageState();
}


class QuestionChosingPageState extends State<QuestionTypeChossingPage> {

  Future openDialog() => showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(15),
            title: const Text("No available Questions"),
            elevation: 8,
            icon: const Icon(
                    Icons.gpp_bad,
                    weight: 50,
                    size: 50,
                  ),
            iconColor:  Colors.redAccent,
            // backgroundColor: Color.fromARGB(225, 241, 237, 237),
            contentTextStyle: const TextStyle(
                color: Color.fromARGB(255, 25, 57, 42),
                fontWeight: FontWeight.bold),
            content: Container(
              alignment: Alignment.center,
              width: 150,
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: const Text(
                textAlign: TextAlign.center,
                "This question catagory doesn't contain any question inserted for now! try again some other time or contact the adminstrator ",
              ),
            ),

            actions: [
              ElevatedButton.icon(
                  style:const ButtonStyle(
                      padding:  MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
                      iconColor:  MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
                  onPressed: () {
                     Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text(
                     "Close and re-try",
                    style:  TextStyle(
                      color: Colors.black,
                    ),
                  ))
            ],
          ));
  

  List allinformationAboutQuestionCollector(String questionType){
    List finalCollectionOfList = [];
    Box<QuestionTypeModel> all_qustion_type = QuestionTypeBox.getAllTheQuestionsTypes();
    

    Box<Question>  all_the_questions = QuestionBox.getAllTheQuestions();
    all_the_questions.toMap().forEach((key, value) {
      
        all_qustion_type.toMap().forEach((keytype, valuetype) {
            if(valuetype.question_type_items.keys.first.toString().trim() == key.toString().trim() && valuetype.question_type_items.values.first.toString().trim() == questionType ){
                  finalCollectionOfList.add(value);  
                }
        });     
    });


    return finalCollectionOfList;
  }

  List randomizeTheList(List all_questions){
   
    List randomeListOfQuestion = [];

    List  imageBasedQuestion = [];
    List textBasedQuestion = [];
    
    
    all_questions.forEach((element) {
      if(element.exam_type == 1){
        textBasedQuestion.add(element);
      }else{
        imageBasedQuestion.add(element);
      }
     
    });

      
    List resolvedImageList = [];
    
    int tottlaAmountquestionAvailable  = textBasedQuestion.length + imageBasedQuestion.length;

    // amount of tottal question required is 30% of the tottal question 
    // and the text is 70% 
    // the 30% can be calculated as follow


    List resolvedItemsOfQuestionImage = [];
    List resolvedItemsOfQuestionText = [];
    
    imageBasedQuestion.shuffle(Random(10000));
  
    int amountofimagerequiredbyPerencent = ((30 * tottlaAmountquestionAvailable) / 100).floor(); // this 30% length of the question so loop until u have this amount of question 
    while(resolvedItemsOfQuestionImage.length != amountofimagerequiredbyPerencent ){
     
        if(resolvedItemsOfQuestionImage.length >= 15){
            break;
        }
        int rd = Random().nextInt(imageBasedQuestion.length);
        Question obj =  imageBasedQuestion [rd] ;
        
        if(!(resolvedItemsOfQuestionImage.contains(obj))){
            resolvedItemsOfQuestionImage.add( obj ); // this will basically generates random number upto max of the list image based and will continue doing this until the new list holds the so called the 30 percenand finally adds them to the new lsit
        }
      }


    textBasedQuestion.shuffle(Random(10000));

    int amountoftextrequiredbyPerencent = ((70 * tottlaAmountquestionAvailable) / 100).floor(); // this 70% length of the question so loop until u have this amount of question  50 = 100 
    while(resolvedItemsOfQuestionText.length != amountoftextrequiredbyPerencent ){
      if(resolvedItemsOfQuestionText.length >= 35){
        break;
      }
      int rd = Random().nextInt(textBasedQuestion.length);
      Question obj =  textBasedQuestion[rd];
      if (!(resolvedItemsOfQuestionText.contains(obj))){
          resolvedItemsOfQuestionText.add(obj);
      }
      
    }


    
    randomeListOfQuestion.addAll(resolvedItemsOfQuestionImage);
    randomeListOfQuestion.addAll(resolvedItemsOfQuestionText);

    randomeListOfQuestion.shuffle();
   
    if(randomeListOfQuestion.length > 50){
        randomeListOfQuestion = randomeListOfQuestion.sublist(0, 50);
        randomeListOfQuestion.shuffle();
    }
    return randomeListOfQuestion;
  }



  
	List questionAndTypeHandler(){
			
			List allthequestionKeys = [];
			QuestionBox.getAllTheQuestions().toMap().forEach((key, value) {
				allthequestionKeys.add(value.key.toString());
			});

			List onlyQuestionAvail = [];
			QuestionTypeBox.getAllTheQuestionsTypes().toMap().forEach((key, value) {
				String questionId = value.question_type_items.keys.toList()[0].toString();
				String questionType = value.question_type_items.values.toList()[0].toString();
				if( allthequestionKeys.contains(questionId )){
					onlyQuestionAvail.add(value);
				}
				
			});
		
		return onlyQuestionAvail;

	}

	List specificQuestionTypeRetriver(String current_type, List resolved_questiontypes){
   List resolved_items = [];
		for(var questiontype in resolved_questiontypes){
			String questionId = questiontype.question_type_items.keys.toList()[0].toString();
			String questionType = questiontype.question_type_items.values.toList()[0].toString();
			if(questionType == current_type.trim()){
				resolved_items.add(questionId);
			}

		}
		return resolved_items;
	}

  @override
  Widget build(BuildContext context) {
    Student object = widget.studentObject;
	String flag_for_page = widget.flag_for_page;

	
	List resolved_questions = questionAndTypeHandler();
	

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
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
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                        
                      
                        if(flag_for_page.toString().trim() == "1"){ // 
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) {
                              return StudentMainLandingPageWidget(object);
                            }),
                          );
                        }else if(flag_for_page.toString().trim() == "2"){ // mock exam taking
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) {
                                return StudentMainLandingPageWidget(object);
                              }),
                            );
                        }else{
                          // for another page the codes goes down here
                          }	
							
                    },
                    icon: const Icon(Icons.backspace_rounded),
                    label: const Text(
                      "Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
],
          ),
               
                  Container(
                      margin: const EdgeInsets.only(top: 25),
                      width: 1000,
                      height: 700,
                      child: Column(
                        children: [
                           Container(
                            child:const Text('የፈተናዉን መደብ ይምረጡ', style: TextStyle(color: Colors.black54, decoration: TextDecoration.none),),   
                          ),
                          Container(
                            width: 1000,
                            height: 600,
                            child: Card(
                              color:const Color.fromRGBO(255, 239, 186, 0.405),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 20,
                              shadowColor: const Color.fromRGBO(255, 239, 186, 1),
                              child: Container(
								child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										Container(
											
											margin: const EdgeInsets.symmetric(vertical: 40),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceEvenly,
												children: [

												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('8',resolved_questions);
																		if(currenSelectedtypequestions.isEmpty){
																			openDialog();
																		}else{
                                        if (flag_for_page.toString().trim()  == "2"){
                                            List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('8')) ;
                                            if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '8', randomizedQuestionsList);
                                                      }),);
                                            }else{
                                                  openDialog();
                                            }
                                        }else{
                                          	Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '8');
                                                }),
																			      );
                                         }  
																		}
																
																	}, 
																	child:Text('ህዝብ 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
															),
														)
														],
													),
												),
												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('9',resolved_questions);
																		if(currenSelectedtypequestions.isEmpty){
																			openDialog();
																		}else{
																				if (flag_for_page.toString().trim()  == "2"){
                                            List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('9')) ;
                                            if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '9', randomizedQuestionsList);
                                                      }),);
                                            }else{
                                                  openDialog();
                                            }

                                        }else{
                                          	Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '9');
                                                }),
																			      );
                                         }
																		}

																	}, 
																	child:Text('ህዝብ 2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
															),
														)
														],
													),
												),
												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('5',resolved_questions);
																		if(currenSelectedtypequestions.isEmpty){
																			openDialog();
																		}else{
																			if (flag_for_page.toString().trim()  == "2"){
                                            List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('5')) ;
                                            if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '5', randomizedQuestionsList);
                                                      }),);
                                            }else{
                                                  openDialog();
                                            }

                                        }else{
                                          	Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '5');
                                                }),
																			      );
                                         }
																		}
																	}, 
																	child:Text('ደረቅ 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
															),
														)
														],
													),
												),
											 ],
											),
										),
										
										Container(
											margin: EdgeInsets.symmetric(vertical: 40),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceEvenly,
												children: [

												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('6',resolved_questions);
																		if(currenSelectedtypequestions.isEmpty){
																			openDialog();
																		}else{
																			if (flag_for_page.toString().trim()  == "2"){
                                            List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('6')) ;
                                            if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '6', randomizedQuestionsList);
                                                      }),);
                                            }else{
                                                  openDialog();
                                            }

                                        }else{
                                          	Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '6');
                                                }),
																			      );
                                         }
																		}
																	}, 
																	child:Text('ደረቅ 2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
																	),
														)
														],
													),
												),
												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('7',resolved_questions);
																		if(currenSelectedtypequestions.isEmpty){
																			openDialog();
																		}else{
																			if (flag_for_page.toString().trim()  == "2"){
                                            List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('7')) ;
                                            if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '7', randomizedQuestionsList);
                                                      }),);
                                            }else{
                                                  openDialog();
                                            }

                                        }else{
                                          	Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '7');
                                                }),
																			      );
                                         }
																		}
																	}, 
																	child:Text('ደረቅ 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
															),
														)
														],
													),
												),
												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('3',resolved_questions);
																		if(currenSelectedtypequestions.isEmpty){
																			openDialog();
																		}else{
																			if (flag_for_page.toString().trim()  == "2"){
                                            List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('3')) ;
                                            if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '3', randomizedQuestionsList);
                                                      }),);
                                            }else{
                                                  openDialog();
                                            }

                                        }else{
                                          	Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '3');
                                                }),
																			      );
                                         }
																		}
																	}, 
																	child:Text('ታክሲ 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),		
															),
														)
														],
													),
												),
											 ],
											),
										),
										
										Container(
											margin: EdgeInsets.symmetric(vertical: 40),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceEvenly,
												children: [

												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('4',resolved_questions);
                                    if(currenSelectedtypequestions.isEmpty){
																			openDialog();
                                     	}else{
																			if (flag_for_page.toString().trim()  == "2"){
                                            List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('4')) ;
                                            if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '4', randomizedQuestionsList);
                                                      }),);
                                            }else{
                                              openDialog();
                                            }

                                        }else{
                                          	Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '4');
                                                }),
																			      );
                                         }
																		}
																	}, 
																	child:Text('ታክሲ 2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
															),
														)
														],
													),
												),
												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('2',resolved_questions);
																		if(currenSelectedtypequestions.isEmpty){
																			openDialog();
																		}else{
																			if (flag_for_page.toString().trim()  == "2"){
                                            List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('2')) ;
                                            if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '2', randomizedQuestionsList);
                                                      }),);
                                            }else{
                                                  openDialog();
                                            }

                                        }else{
                                          	Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '2');
                                                }),
																			      );
                                         }
																		}
																	}, 
																	child:Text('አዉቶሞቢል', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
															),
														)
														],
													),
												),
												Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color.fromRGBO(255, 239, 186, 1),),
													),
													child: Row(
													children: [
														Container(
															height: 50,
															child: const Icon(Icons.abc, size: 20,),
														),
														
														Container(
															width: 250,
															height: 50,
																child:ElevatedButton(
																	style: ButtonStyle(backgroundColor:MaterialStateProperty.all( Colors.green),),
																	onPressed: (){
																		List currenSelectedtypequestions = specificQuestionTypeRetriver('1',resolved_questions);
																		if(currenSelectedtypequestions.isEmpty){
																			openDialog();
																		}else{
														
                                            if (flag_for_page.toString().trim()  == "2"){
                                              List randomizedQuestionsList = randomizeTheList(allinformationAboutQuestionCollector('1')) ;
                                              if(randomizedQuestionsList.isNotEmpty){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                          return StudentExamTakingPageWidget(object, flag_for_page.toString().trim() , '1', randomizedQuestionsList);
                                                      }),);
                                              }else{
                                                  openDialog();
                                              }

                                            }else{
                                          	  Navigator.of(context).pushReplacement(
																			        	MaterialPageRoute(builder: (ctx) { 
                                                    return QuestionListDisplayPageWidget(flag_for_page.toString().trim() , object, '1');
                                                }),
																			      );
                                         } 
		
																		}
																	}, 
																	child:Text('ሞተርሳይክል', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
															),
														)
														],
													),
												),
											 ],
											),
										),
										
									

									],
								),
							  ),


                              ),
                          )
                        ],
                      ))
              
         ],
      ),
    );
  }
}

/*

ሞተርሳይክል
አዉቶሞቢል
ታክሲ 2
ታክሲ 1
ደረቅ 1
ደረቅ 2 
ደረቅ 3
ህዝብ 1
ህዝብ 2

ህዝብ 2 : 9

ህዝብ 1 : 8

ደረቅ 3 : 7

ደረቅ 2 : 6

ደረቅ 1 : 5

ታክሲ 2 : 4 --3
ታክሲ 1 : 3  --4
አዉቶሞቢል : 2
ሞተርሳይክል : 1

 */



