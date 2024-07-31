import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'signup.dart';
import 'login.dart';
import 'chat.dart';
import 'jobmatches.dart';


class Home extends StatefulWidget {
  const Home({super.key, required this.loggedInEmail, required this.accommodations});

  final String loggedInEmail;
  final String accommodations;


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
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container (
            //height: height / 3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                //alignment: FractionalOffset.topCenter,
                image: ExactAssetImage ("assets/infinitylogo.png")
              )
            ),
          ),
        ),
        // title: Row(
        //   children: [
            
        //   ],
        // ),
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                        "Neu-Link",
                        style: TextStyle(fontSize: 75),
                        ),
                        TextButton(
                          onPressed: ()
                          {
                            Navigator.push(
                              context, 
                              MaterialPageRoute
                              (
                                builder: (context) {
                                  if (widget.loggedInEmail == "") return SignUp();
                                  return JobMatches(email: widget.loggedInEmail, accommodations: widget.accommodations, firsTime: false,);
                                }
                              )
                            );
                          }, 
                          child: widget.loggedInEmail == "" ? 
                          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 5, color: MyColors.myOnPrimary), ), child: const Padding(padding: EdgeInsets.all(7.5), child: Text("Start Finding", style: TextStyle(fontSize: 20)))) : 
                          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 5, color: MyColors.myOnPrimary), ), child: const Padding(padding: EdgeInsets.all(7.5), child: Text("Check My Match", style: TextStyle(fontSize: 20))))
                        )
                      ]
                    ),
                  )
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  color: MyColors.myOnBackground,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: width/6.5,),
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Container (
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: ExactAssetImage ("assets/bigLogo.png")
                                )
                              ),
                            ),
                          ),
                          
                        ]
                      ),
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
              ],

          ),
        
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: ()
        {
          Navigator.push(
            context, 
            MaterialPageRoute
            (
              builder: (context) => Chat()
            )
          );
        },
        child: SizedBox(
          height: height / 10,
          child: const Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat, size: 50,),
              Text("Interview Practice",)
            ]
          ),
        )
        

      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}