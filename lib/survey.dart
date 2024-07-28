import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';

 

class Survey extends StatefulWidget {
  const Survey({Key? key}) : super(key: key);

  
  @override
  State<Survey> createState() => _SurveyState();
}


class _SurveyState extends State<Survey> {

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
      body: const Center(
        
      ),
    );
  }
}