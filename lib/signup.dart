import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';
import 'survey.dart';
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

  bool incorrect = false;
  bool loading = false;

  Future<void> _submitSection() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("Sheet1"); 
      final submission = [username, password]; 
      final user = await sheet!.values.rowByKey(email);
      if (user == null){
        if (email.contains("@") && email.contains(".com")){
          
          await sheet.values.insertRowByKey (email, submission);

           setState(() {
            incorrect = false;
            
           });

          if (context.mounted){
            Navigator.push(
              context, 
              MaterialPageRoute
              (
                builder: (context) => Survey(email: email,)
              )
            );
          }
          
        }
        else{
          setState(() {
            incorrect = true;
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (loading){
      return const Scaffold
      (
        body: Center
        (
          child: Text("Loading... (Takes ~5s)", style: TextStyle(fontSize: 50),)
        )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up for",),
        elevation: 15,
      ),
      body: Center(
        child: Column(
          children: [
            incorrect ? const Padding(padding: EdgeInsets.only(top: 20, bottom: 5), child: Text("Password or email incorrect", style: TextStyle(color: MyColors.myOnPrimary),)) : const SizedBox(),
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
                        decoration: const InputDecoration(
                          hintText: "Anything works!"
                        ),
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
                        decoration: const InputDecoration(
                          hintText: "Doesn't have to be a real email, we're just testing!"
                        ),
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
                        decoration: const InputDecoration(
                          hintText: "Any password is fine, doesn't need to be email password"
                        ),
                        cursorColor: MyColors.myOnSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
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