import 'package:flutter/material.dart';
import 'package:snp_job/home.dart';
import 'color_scheme.dart';


String id = "";
class Entrance extends StatefulWidget {
  const Entrance({super.key});


  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: TextField(
          onChanged: (String value) {
            setState(() {
              id = value;
            });
          },
          cursorColor: MyColors.myOnSurface,
        ),
      ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: (){
          if (id == "hi"){
            Navigator.push(
              context, 
              MaterialPageRoute
              (
                builder: (context) => const Home()
              )
            );
          }
        }
      ),
    );
  }
}