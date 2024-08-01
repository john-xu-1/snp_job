import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';
import 'home.dart';

const List<String> accommodations = <String>["Sense of workplace community",
    "Programs specifically designed for people on the spectrum",
    "Mental health support program",
    "Remote work available",
    "Sensory room",
    "Adjustable lighting",
    "Adapted hiring process",
    "Job coaches",
    "Extra time",
    "Closed captioning/interpreter",
    "ADA accessible building",
    "Flexible scheduling",
    "Multiple means of communication",
    "Schedule of objectives for the day - less hidden curriculum",
    "Egalitarian workplace",
    "Generous PTO",
    "Healthcare plan",
    "Flexible interview options"];

class JobMatches extends StatefulWidget {
  const JobMatches({Key? key, required this.email, required this.accommodations, required this.firsTime}) : super(key: key);

  final String email;
  final String accommodations;
  final bool firsTime;
  @override
  State<JobMatches> createState() => _JobMatchesState();
}


class _JobMatchesState extends State<JobMatches> {

  List<String> jobMatched = List.empty(growable: true);
  List<String> jobMatchedAccm = List.empty(growable: true);

  Future<void> _submitSection() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("matching info"); 
      //final user = await sheet!.values.rowByKey(email);
      List<String> splitted = widget.accommodations.split(", ");
      print (splitted);
      if (splitted.isNotEmpty){
        for (int i = 0; i < splitted.length - 1; i++){
          for (int j = 0; j < 8; j++){
            final user = await sheet!.values.row(j+1);
            if (user[1].contains(splitted[i]) && !jobMatched.contains(user[0]))
            {
              jobMatched.add(user[0]);
              jobMatchedAccm.add(user[1]);
            }
          }
        }
      }
      
      print (jobMatched);
      setState(() {
        
      });
      // final submission = [fullAccommodations]; 
      // await sheet!.values.insertRowByKey (widget.email, submission, fromColumn: 4);

    } catch (e) {
      print('Error: $e');
    }
  }
  
  @override
  void initState() {
    super.initState();
    _submitSection();
  }
  

  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    if (jobMatched.isEmpty && widget.accommodations.isNotEmpty){
      return Scaffold
      (
        body: Center
        (
          child: widget.firsTime ? const Text("Finding Your Match!", style: TextStyle(fontSize: 50),)
          : const Text("Fetching Your Preferences", style: TextStyle(fontSize: 50),)
        )
      );
    }
    return Scaffold(
      body: Center(
        child: ListView.separated
        (
          padding: const EdgeInsets.all(8),
          itemCount: jobMatched.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: height/8,
              child: Container
              (                
                color: MyColors.myOnBackground,
                child: Row(
                  children: [
                    Text(jobMatched[index], style: const TextStyle(fontSize: 20),),
                    const SizedBox(width: 20,),
                    Text(jobMatchedAccm[index], style: const TextStyle(fontSize: 20),),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Container(
            alignment: AlignmentDirectional.center,
            height: height / 150,
          ),
            
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        _submitSection();

        Navigator.push(
          context, 
          MaterialPageRoute
          (
            builder: (context) => Home(loggedInEmail: widget.email, accommodations: widget.accommodations)
          )
        );
      },
      child: const Icon(Icons.arrow_back),
      ),
    );
  }
}