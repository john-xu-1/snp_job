import 'package:flutter/material.dart';
import 'job_survey.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';
import 'pref_survey.dart';
import 'login.dart';
 

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  
  @override
  State<SignUp> createState() => _SignUpState();
}




class _SignUpState extends State<SignUp> {

  String username= "";
  String email = "";
  String password = "";
  bool isEmployed = false;

  bool incorrect = false;
  bool loading = false;

  Future<void> _submitSection() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("login info"); 
      final submission = [username, password];
      if (email == ""){
        setState(() {
          incorrect = true;
          loading = false;
        });
        return;
      }
      final user = await sheet!.values.rowByKey(email);
      if (user == null){
        if (email.contains("@") && email.contains(".com")){
          
          await sheet.values.insertRowByKey (email, submission);

           setState(() {
            incorrect = false;
            loading = false;
           });

          if (context.mounted){
            Navigator.push(
              context, 
              MaterialPageRoute
              (
                builder: (context) {
                  if (isEmployed) return JobSurvey(email: email);
                  return PrefSurvey(email: email,);
                } 
              )
            );
          }
          
        }
        else{
          setState(() {
            incorrect = true;
            loading = false;
          });
        }
      }
      else{
        
        if (user[0] == username && user[1] == password){

          setState(() {
            incorrect = false;
           });
           
          if (context.mounted){
            Navigator.push(
              context, 
              MaterialPageRoute
              (
                builder: (context) => const LogIn()
              )
            );
          }

        }
        else{
          setState(() {
            incorrect = true;
            loading = false;
          });
        }
      }

      
      //await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 13);
    } catch (e) {
      print('Error: $e');

    }
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (loading){
      return Scaffold
      (
        body: Container(
          color: MyColors.myBackground,
          child: const Center
          (
            child: Text("Loading... (Takes ~5s)", textScaleFactor: 3,)
          ),
        )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up to Start Searching",),
        elevation: 15,
      ),
      body: Center(
        child: Container(
          //color: MyColors.myBackground,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffeebg.png'),
                                
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeatY,
              ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              incorrect ? const Padding(padding: EdgeInsets.only(top: 20, bottom: 5), child: Text("Password or email incorrect", style: TextStyle(color: MyColors.myOnPrimary),)) : const SizedBox(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 15, bottom: 10), child: SizedBox(width: width/3 ,child: const Row(children: [ Text("Username",textScaleFactor: 1.5, textAlign: TextAlign.left,)]))),
                  SizedBox(
                    width: width /3,
                    child: TextField(
                      onChanged: (String value) {
                        setState(() {
                          username = value;
                        });
                      },
                      cursorColor: const Color.fromARGB(255, 0, 0, 0),
                      //style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.myOnPrimary,
                          ),
                          //borderRadius: BorderRadius.circular(5.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:MyColors.myOnPrimary
                          ),
                        ),
                        filled: true,
                        fillColor: MyColors.myBackground,
                        hintText: "Anything works!",
                        //hintStyle: TextStyle(color: MyColors.myOnPrimary, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 15, bottom: 10), child: SizedBox(width: width/3 ,child: const Row(children: [ Text("Email",textScaleFactor: 1.5, textAlign: TextAlign.left,)]))),
                  SizedBox(
                    width: width /3,
                    child: TextFormField(
                      onChanged: (String value) { 
                        setState(() {
                          email = value;
                        });
                      },
                      cursorColor: const Color.fromARGB(255, 0, 0, 0),
                      //style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.myOnPrimary,
                          ),
                          //borderRadius: BorderRadius.circular(5.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:MyColors.myOnPrimary
                          ),
                        ),
                        filled: true,
                        fillColor: MyColors.myBackground,
                        hintText: "Any email that contains '@' and '.com' is fine, we're just testing!",
                        //hintStyle: TextStyle(color: MyColors.myOnPrimary, fontSize: 15),
                      ),
                    )
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 15, bottom: 10), child: SizedBox(width: width/3 ,child: const Row(children: [ Text("Password",textScaleFactor: 1.5, textAlign: TextAlign.left,)]))),
                  SizedBox(
                    width: width /3,
                    child: TextField(
                      //int.parse(value)
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                      cursorColor: const Color.fromARGB(255, 0, 0, 0),
                      //style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColors.myOnPrimary,
                          ),
                          //borderRadius: BorderRadius.circular(5.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:MyColors.myOnPrimary
                          ),
                        ),
                        filled: true,
                        fillColor: MyColors.myBackground,
                        hintText: "Any password is fine, doesn't have to be email passwords!",
                        //hintStyle: TextStyle(color: MyColors.myOnPrimary, fontSize: 15),
                      )
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  const Text("Do you have previous job experiences? ", textScaleFactor: 1.3,),
                  Checkbox(
                    value: isEmployed,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        isEmployed = newValue!;
                      });
                    },
                  ),
                ]
              ),
              //const SizedBox (height: 15,),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  _submitSection();
              
              
                },
                child: const Icon(Icons.send,),
              )
            ],
          ),
        )
      ),
    );
  }
}