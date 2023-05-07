import 'package:diving_licence_traning_center_student/Components/sideBarDrawer.dart';
import 'package:flutter/material.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import '../Models/StudentModels.dart';
import '../Models/StudentFavoriteModel.dart';
import './sideBarDrawer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Admin_login_page.dart';
import 'adminStudentInformationDetailViewPage.dart';

class AdminSideStudentManagementWidget extends StatefulWidget {
   AdminSideStudentManagementWidget();


  @override
  State<AdminSideStudentManagementWidget> createState() =>
      AdminSideStudentManagementState();
}

class AdminSideStudentManagementState extends State<AdminSideStudentManagementWidget> {
  

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      drawer:  SidebarDrawerWidget(3),
       appBar: AppBar(
          foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
          backgroundColor: const Color(0xFF65647C),
          title: const Text(
            'Manage Students Information',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: IconButton(
                onPressed: () {
                   Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) {
                  return AdminLoginPageWidget();
                }),
              );
                },
                icon: const Icon(Icons.logout),
                iconSize: 35,
              ),
            ),
          ],
        ),

      body:  Container(
      
      constraints: const BoxConstraints.expand(),
      width: double.infinity,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/backgroundEntrance.jpg'),
          ),
      ),  
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              //   width: 150,
              //   height: 45,
              //   child: ElevatedButton.icon(
              //       style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.all(Colors.black38),
              //       ),
              //       onPressed: () {
              //         // Navigator.of(context).pushReplacement(
              //         //   MaterialPageRoute(builder: (ctx) {
              //         //     return StudentMainLandingPageWidget(object);
              //         //   }),
              //         // );
              //       },
              //       icon: const Icon(Icons.logout),
              //       label: const Text(
              //         "ወድ ኋላ; ተመለስ",
              //         style:
              //             TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //       )),
              // ),
              
            ],
          ),

      Expanded(
        child: 
          Column(
									children: [
										Container(
											margin: EdgeInsets.symmetric(vertical: 50),
											child: const Text(
												"All Student List",
												style: TextStyle(
														fontFamily: 'quickSand',
														decoration: TextDecoration.underline,
														color: Colors.white,
														fontWeight: FontWeight.bold,
														fontSize: 30),
											),
										),
                   Expanded(child: ListItemBuilderWidget(),),
									],
								)),
          
        ],
      ),
      
    )
    );
  }
}



class ListItemBuilderWidget extends StatefulWidget {
	const ListItemBuilderWidget({super.key});

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
		    

  Box<Student> allstudents = StudentBox.getAllTheStudentsInfo();
	List<Student> value = [];
  allstudents.toMap().forEach((key, values) {
      value.add(values);
  });
 
		if(value.length <=  0){
			return Center(
									child: Container(
										margin: EdgeInsets.only(bottom: 150),
										alignment: Alignment.center,
										child: const Text(
											"No Registered Student Found In The Database",
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
			
				valueListenable:  StudentBox.getAllTheStudentsInfo().listenable(),
				
				builder: (context, box, child) {
					return (value.length > 0)
							? ListView.builder(
									itemCount: value.length,
									itemBuilder: (context, int index) => InkWell(
										onTap: () {
											Navigator.of(context).push(
												MaterialPageRoute(builder: (ctx) {
													return AdminSideStudentManagementDetailWidget(value[index]);
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
																			'Name:  ${value[index].
																					fullName.toString()}',
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
								"No Registered Student Found In The Database",
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
