import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';
import 'home.dart';

 

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}


class _LogInState extends State<LogIn> {

  String email= "";
  String password = "";
  bool incorrect = false;

  Future<void> _submitSection() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("Sheet1"); 
      final user = await sheet!.values.rowByKey(email);
      if (user == null){
        setState(() {
          incorrect = true;
        });
      }
      else{
        if (user[1] == password)
        {
          setState(() {
            incorrect = false;
          });
          
          if (context.mounted){
            Navigator.push(
              context, 
              MaterialPageRoute
              (
                builder: (context) => Home(loggedInEmail: email,)
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In",),
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
              onPressed: () => _submitSection(),
              child: const Icon(Icons.send),
            )
          ],
        )
      ),
    );
  }
}