import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'signup.dart';
import 'login.dart';
import 'chat.dart';


class Home extends StatefulWidget {
  const Home({super.key, required this.loggedInEmail});

  final String loggedInEmail;


  @override
  State<Home> createState() => _HomeState();
}
bool hoverSignup = false;
bool hoverLogin = false;

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 222, 222),
        leading: const Icon(Icons.menu),
        title: const Row(
          children: [
            Text("Neuro"),
          ],
        ),
        actions:[
          if (widget.loggedInEmail == "") 
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.myOnPrimary),
                      color: hoverLogin ? MyColors.myOnBackgroundD: const Color.fromARGB(0, 255, 255, 255)
                    ),
                    child: TextButton(
                      onHover: (bool value){
                        setState(() {
                          hoverLogin = value;
                        });
                      },
                      onPressed: () {  
                        Navigator.push(
                          context, 
                          MaterialPageRoute
                          (
                            builder: (context) => const LogIn()
                          )
                        );
                      },
                      child: const Text("Log in", style: TextStyle(color: MyColors.myOnSurface),),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.myOnPrimary),
                      color: hoverSignup ? MyColors.myOnBackgroundD: const Color.fromARGB(0, 255, 255, 255)
                    ),
                    child: TextButton(
                      onHover: (bool value){
                        setState(() {
                          hoverSignup = value;
                        });
                      },
                      onPressed: () { 
                        print ('right button') ;
                        Navigator.push(
                          context, 
                          MaterialPageRoute
                          (
                            builder: (context) => const SignUp()
                          )
                        );
                      },
                      child: const Text("Sign up", style: TextStyle(color: MyColors.myOnSurface),),
                    ),
                  )
                ],
              ),
            )
          else const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.person),
          )
        ],
        elevation: 21,
      ),
      body: Center(
         child: Container(
            color: MyColors.myPrimaryColor,
            child: ListView(
              //padding: const EdgeInsets.only(top: 10, bottom: 10),
              children: <Widget>[
                Container(
                  height: height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      //alignment: FractionalOffset.topCenter,
                      image: ExactAssetImage ("assets/work.png")
                    )
                  ),
                  child: const Center(
                    child: Text(
                      "Project Name",
                      style: TextStyle(fontSize: 75),
                      ),
                  )
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  color: MyColors.myOnBackground,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width/2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Our Mission",
                              style: TextStyle(fontSize: 50)
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: width * 0.95,
                              child: const Text(
                                "Users needs insight on job opportunities because information isn't very accessible to them. Our users are specifically any autstic job seekers (age 16 and above). Our goal is to provide them with information and insight on job opportunities to help them gain a sense of self dependency. We also help them feel more financially stable/ independent by increasing accessibility for them. Finding an effective solution for this will impact positively to general well being and sense of atonomy of neurodiverse individuals, as it will help them feel included in society, confident, and more aware of their specific skill set. ",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Icon (Icons.abc)
                    ],
                  )
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  color: MyColors.mySurface,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: width*0.4,),
                      SizedBox(
                        width: width/2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            const Text(
                              "About Us",
                              style: TextStyle(fontSize: 50),
                              textAlign: TextAlign.right,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: width * 0.95,
                              child: const Text(
                                "Users needs insight on job opportunities because information isn't very accessible to them. Our users are specifically any autstic job seekers (age 16 and above). Our goal is to provide them with information and insight on job opportunities to help them gain a sense of self dependency. We also help them feel more financially stable/ independent by increasing accessibility for them. Finding an effective solution for this will impact positively to general well being and sense of atonomy of neurodiverse individuals, as it will help them feel included in society, confident, and more aware of their specific skill set. ",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                      ),
                      
                    ],
                  )
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    //color: Color.fromARGB(20, 62, 62, 62)
                    color: MyColors.myOnBackground
                  ),
                  //color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100,
                        onPressed: (){
                          // Navigator.push(
                          //   context, 
                          //   MaterialPageRoute
                          //   (
                          //     builder: (context) => const TeamDisplayChoice(),
                          //   )
                          // );
                        },  
                        icon: const Icon(Icons.data_array),
                        color: Colors.black,
                      ),
                      const Text(""),
                    ],
                  )
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    //color: Color.fromARGB(20, 62, 62, 62)
                    color: MyColors.myOnBackground
                  ),
                  //color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100,
                        onPressed: (){
                          // Navigator.push(
                          //   context, 
                          //   MaterialPageRoute
                          //   (
                          //     builder: (context) => const TeamDisplayChoice(),
                          //   )
                          // );
                        },  
                        icon: const Icon(Icons.data_array),
                        color: Colors.black,
                      ),
                      const Text(""),
                    ],
                  )
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    //color: Color.fromARGB(20, 62, 62, 62)
                    color: MyColors.myOnBackground
                  ),
                  //color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100,
                        onPressed: (){
                          // Navigator.push(
                          //   context, 
                          //   MaterialPageRoute
                          //   (
                          //     builder: (context) => const TeamDisplayChoice(),
                          //   )
                          // );
                        },  
                        icon: const Icon(Icons.data_array),
                        color: Colors.black,
                      ),
                      const Text(""),
                    ],
                  )
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    //color: Color.fromARGB(20, 62, 62, 62)
                    color: MyColors.myOnBackground
                  ),
                  //color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100,
                        onPressed: (){
                          // Navigator.push(
                          //   context, 
                          //   MaterialPageRoute
                          //   (
                          //     builder: (context) => const TeamDisplayChoice(),
                          //   )
                          // );
                        },  
                        icon: const Icon(Icons.data_array),
                        color: Colors.black,
                      ),
                      const Text(""),
                    ],
                  )
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    //color: Color.fromARGB(20, 62, 62, 62)
                    color: MyColors.myOnBackground
                  ),
                  //color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100,
                        onPressed: (){
                          // Navigator.push(
                          //   context, 
                          //   MaterialPageRoute
                          //   (
                          //     builder: (context) => const TeamDisplayChoice(),
                          //   )
                          // );
                        },  
                        icon: const Icon(Icons.data_array),
                        color: Colors.black,
                      ),
                      const Text(""),
                    ],
                  )
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    //color: Color.fromARGB(20, 62, 62, 62)
                    color: MyColors.myOnBackground
                  ),
                  //color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100,
                        onPressed: (){
                          // Navigator.push(
                          //   context, 
                          //   MaterialPageRoute
                          //   (
                          //     builder: (context) => const TeamDisplayChoice(),
                          //   )
                          // );
                        },  
                        icon: const Icon(Icons.data_array),
                        color: Colors.black,
                      ),
                      const Text(""),
                    ],
                  )
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    //color: Color.fromARGB(20, 62, 62, 62)
                    color: MyColors.myOnBackground
                  ),
                  //color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 100,
                        onPressed: (){
                          // Navigator.push(
                          //   context, 
                          //   MaterialPageRoute
                          //   (
                          //     builder: (context) => const TeamDisplayChoice(),
                          //   )
                          // );
                        },  
                        icon: const Icon(Icons.data_array),
                        color: Colors.black,
                      ),
                      const Text(""),
                    ],
                  )
                ),
              ],

          ),
        
        ),
      ),
      floatingActionButton: 
      IconButton
      (
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute
            (
              builder: (context) => Chat()
            )
          );
        },
        icon: const Icon(Icons.chat),

      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}