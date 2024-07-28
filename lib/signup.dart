import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';

 

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  
  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {

  String username= "";
  String email = "";
  String password = "";

  Future<void> _submitSection() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("Sheet1"); 
      final submission = [username, password]; 
      final user = await sheet!.values.rowByKey(email);
      if (user == null){
        if (email.contains("@") && email.contains(".com")){
          await sheet.values.insertRowByKey (email, submission);
          //send to survey
        }
        else{
          print ("email error");
        }
      }
      else{
        
        if (user[0] == username && user[1] == password){
          print ("logged in instead");
        }
        else{
          print ("sus user lol");
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("match scouting log in",),
      //   elevation: 21,
      // ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height / 4.5,
              //color: Colors.red[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Username",textScaleFactor: 1.5,),
                    SizedBox(
                      width: width /3,
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            username = value;
                          });
                        },
                        cursorColor: MyColors.myOnSurface,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 4.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Email",textScaleFactor: 1.5,),
                    SizedBox(
                      width: width /3,
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            email = value;
                          });
                        },
                        cursorColor: MyColors.myOnSurface,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height/4.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Password",textScaleFactor: 1.5,),
                    SizedBox(
                      width: width /3,
                      child: TextField(
                        //int.parse(value)
                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                        cursorColor: MyColors.myOnSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submitSection();

              },
              child: const Icon(Icons.send),
            )
          ],
        )
      ),
    );
  }
}