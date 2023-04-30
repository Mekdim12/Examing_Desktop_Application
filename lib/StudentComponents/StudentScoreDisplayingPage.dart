import 'package:flutter/material.dart';
import '../Models/ScoreModel.dart';
import '../Models/StudentModels.dart';
import 'StudentMainLandingPage.dart';
import 'package:flutter/material.dart';
import '../Models/QuestionModel.dart';

import 'package:diving_licence_traning_center_student/StudentComponents/StudentMainLandingPage.dart';
import 'package:flutter/material.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import '../Models/StudentModels.dart';
import '../Models/StudentFavoriteModel.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'StudentFavQuestionDetailViewPage.dart';


class StudentScoreDisplayWidget extends StatefulWidget {
   StudentScoreDisplayWidget(this.studentObject,{super.key});
   Student studentObject;
  @override
  State<StudentScoreDisplayWidget> createState() => _StudentScoreDisplayState();
}

class _StudentScoreDisplayState extends State<StudentScoreDisplayWidget> {
  @override
  Widget build(BuildContext context) {
   Student studentObject = widget.studentObject;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    Box<StudentScoreModel> allscoreInformation = StudentScoreBox.getAllStudentsScore();
    
    List value = [];
    allscoreInformation.toMap().forEach((key, values) {

      if(values.studentScore.keys.first == studentObject.id_number){
          value.add(values.studentScore.values);
       } 

    });


  int passedExamCount = 0;
  int failedExamCount = 0;

  for (var element in value) {
    
    if(element.first[4]){

     passedExamCount++;
    }else{
      failedExamCount++;
    }
   
  }


    return  Scaffold(
    body:
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black38),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return StudentMainLandingPageWidget(studentObject);
                        }),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "ወደ ኋላ ተመለስ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
            ],
          ),

          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 
                  Container(
                    height: 260,
                    width: 350,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                      ),
                      borderOnForeground: true,
                      color: const Color(0xFFBCEAD5),
                      // color: const Color.fromARGB(255, 188, 243, 209),
                      elevation: 10,
                      child: Column(
                        children: [
                          
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 15)),
                           Text(
                            value.length.toString(),
                            selectionColor: Color.fromARGB(255, 188, 243, 209),
                            style: const TextStyle(
                                letterSpacing: 5,
                                fontFamilyFallback: ['OpenSans'],
                                wordSpacing: 545,
                                // color: Color.fromARGB(255, 47, 161, 51),
                                color: Color.fromARGB(255, 87, 129, 113),
                                fontSize: 70,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: const Text(
                              "ጠቅላላ የተፈተኗቸው ፈተናዎች ብዛት ",
                              style: TextStyle(
                                  fontFamily: 'quickSand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                   Container(
                    height: 260,
                    width: 350,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                      ),
                      borderOnForeground: true,
                      color: const Color(0xFFBCEAD5),
                      // color: const Color.fromARGB(255, 188, 243, 209),
                      elevation: 10,
                      child: Column(
                        children: [
                          
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 15)),
                           Text(
                            "${passedExamCount}",
                            selectionColor: Color.fromARGB(255, 188, 243, 209),
                            style: TextStyle(
                                letterSpacing: 5,
                                fontFamilyFallback: ['OpenSans'],
                                wordSpacing: 545,
                                // color: Color.fromARGB(255, 47, 161, 51),
                                color: Color.fromARGB(255, 87, 129, 113),
                                fontSize: 70,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: const Text(
                              "ያለፉት ፈተናዎች ብዛት",
                              style: TextStyle(
                                  fontFamily: 'quickSand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                 
                  
                  Container(
                    height: 260,
                    width: 350,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                      ),
                      borderOnForeground: true,
                      color: const Color(0xFFBCEAD5),
                      // color: const Color.fromARGB(255, 188, 243, 209),
                      elevation: 10,
                      child: Column(
                        children: [
                          
                          
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 15)),
                           Text(
                            "${failedExamCount}",
                            selectionColor: Color.fromARGB(255, 188, 243, 209),
                            style: TextStyle(
                                letterSpacing: 5,
                                fontFamilyFallback: ['OpenSans'],
                                wordSpacing: 545,
                                // color: Color.fromARGB(255, 47, 161, 51),
                                color: Color.fromARGB(255, 87, 129, 113),
                                fontSize: 70,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: const Text(
                              "የወደቁት ፈተናዎች ብዛት",
                              style: TextStyle(
                                  fontFamily: 'quickSand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
        child: 
          Column(
									children: [
										Container(
											margin: EdgeInsets.symmetric(vertical: 50),
											child: const Text(
												"የፈተና መረጃዎች ዝርዝር",
												style: TextStyle(
														fontFamily: 'quickSand',
														decoration: TextDecoration.underline,
														color: Colors.black,
														fontWeight: FontWeight.bold,
														fontSize: 22),
											),
										),
                   Expanded(child: ListItemBuilderWidget(studentObject),),
									],
								)),
        ],
        
        
        )
           
    ),);


       
       
}}







class ListItemBuilderWidget extends StatefulWidget {
	const ListItemBuilderWidget( this.studentObject,{super.key});

	// final int flag;

  
  // final String questionType;
  final Student studentObject;

	@override
	State<ListItemBuilderWidget> createState() => _ListItemBuilderState();
}

class _ListItemBuilderState extends State<ListItemBuilderWidget> {
	int indexOfHovered = 0;
	bool isContainerHovered = false;
	bool isDeleteButtonPressed = false;
	bool isDeleteHover = false;

  


	

	@override
	Widget build(BuildContext context) {
		

    Box<StudentScoreModel> allscoreInformation = StudentScoreBox.getAllStudentsScore();
    Student studentObject = widget.studentObject;
    

    List value = [];
    allscoreInformation.toMap().forEach((key, values) {

      if(values.studentScore.keys.first == studentObject.id_number){
          value.add(values.studentScore.values);
       } 

    });

    // print(DateTime.parse(value[index].first[0]).year.toString());

		if(value.length <=  0){
			return Center(
									child: Container(
										margin: EdgeInsets.only(bottom: 150),
										alignment: Alignment.center,
										child: const Text(
											"በርሶ መታወቂያ ቁጥር የተመዘገበ መረጃ የለም",
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
				

					return ValueListenableBuilder(
			
				valueListenable: StudentScoreBox.getAllStudentsScore().listenable(),
				
				builder: (context, box, child) {
					return (value.length > 0)
							? ListView.builder(
									itemCount: value.length,
									itemBuilder: (context, int index) => InkWell(
										onTap: () {
											// Navigator.of(context).push(
											// 	MaterialPageRoute(builder: (ctx) {
											// 		return StudentFavoriteDetailPageWidget(studentObject,  value[index]);
											// 	}),
											// );
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
														: (value[index].first[4])? Color.fromARGB(118, 105, 240, 175) : Color.fromARGB(135, 255, 82, 82),
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
																					fontSize: 22),
                                          ),
																],
															),
														),
														Flexible(
															child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
															  children: [
															    Column(
															    	mainAxisAlignment: MainAxisAlignment.center,
															    	crossAxisAlignment: CrossAxisAlignment.start,
															    	children: [
															    		Container(
															    			child: Text(
															    				maxLines: 2,
															    				softWrap: true,
															    				 'የጥያቄ ብዛት ፡ ${value[index].first[1].toString()}',
															    				style: const TextStyle(
															    						color: Colors.black87,
															    						fontWeight: FontWeight.bold,
															    						fontSize: 16
                                          ),
															    			),
															    		),
                                  Container(margin: EdgeInsets.symmetric(vertical: 5),),
                                  Text('የፈተናው ቀን ፡ ${DateTime.parse(value[index].first[0].toString()).year.toString()}-${DateTime.parse(value[index].first[0].toString()).month.toString()}-${DateTime.parse(value[index].first[0].toString()).day.toString()}')
															    	],
															    ),
															  
                                //  Container(alignment: Alignment.center,),    

                                 Container(
                                   child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
															    	crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
															    				maxLines: 2,
															    				softWrap: true,
															    				 'በትክክል የተመለሱ ጥያቄዎች ብዛት ፡ ${value[index].first[2].toString()}',
															    				style: const TextStyle(
															    						color: Colors.black87,
															    						fontWeight: FontWeight.bold,
															    						//fontSize: 16
                                          ),
															    			),
                                      Container(margin: EdgeInsets.symmetric(vertical: 5),),
                                      Text(
															    				maxLines: 2,
															    				softWrap: true,
															    				 'በትክክል ያልተመለሱ ጥያቄዎች ብዛት ፡ ${value[index].first[3].toString()}',
															    				style: const TextStyle(
															    						color: Colors.black87,
															    						fontWeight: FontWeight.bold,
															    						// fontSize: 16
                                          ),
															    			)
                                    ],
                                   ),
                                 ),

                                   Container(
                                   child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
															    	crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
															    				maxLines: 2,
															    				softWrap: true,
															    				(value[index].first[5])? 'የፈተናውን ደቂቃ በተገቢው ሁኔታ ተጠቅመዋል' : 'የፈተናውን ደቂቃ በአግባቡ አልተጠቀሙም',
															    				style: const TextStyle(
															    						color: Colors.black87,
															    						fontWeight: FontWeight.bold,
															    						// fontSize: 16
                                          ),
															    			),
                                      Container(margin: EdgeInsets.symmetric(vertical: 5),),
                                      Text(
															    				maxLines: 2,
															    				softWrap: true,
															    				(value[index].first[4])? 'አልፈዋል': 'ወድቀዋል',
															    				style: const TextStyle(
															    						color: Color.fromARGB(129, 0, 0, 0),
															    						fontWeight: FontWeight.bold,
															    						// fontSize: 16
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
									),
								)
							: Center(
									child: Container(
										margin: EdgeInsets.only(bottom: 150),
										alignment: Alignment.center,
										child: const Text(
											"በርሶ የተመዘገበ መረጃ የለም",
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
								"በርሶ የተመዘገበ መረጃ የለም",
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
