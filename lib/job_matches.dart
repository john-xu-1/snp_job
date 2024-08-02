import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';
import 'home.dart';

const List<String> accommodations = <String>[
  "ADA accessible building",
  "Adapted hiring process",
  "Adjustable lighting",
  "Closed captioning/interpreter",
  "Egalitarian workplace",
  "Extra time",
  "Flexible interview options",
  "Flexible scheduling",
  "Generous PTO",
  "Healthcare plan",
  "Internships",
  "Job coaches",
  "Mental health support program",
  "Multiple means of communication",
  "Programs specifically designed for people on the spectrum",
  "Remote work available",
  "Schedule of objectives for the day - less hidden curriculum",
  "Sensory room",
  "Sense of workplace community"
];

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
      final rows = await sheet!.values.allRows();
      List<String> splitted = widget.accommodations.split(", ");
      print (splitted);
      if (splitted.isNotEmpty){
        for (int i = 0; i < splitted.length - 1; i++){
          for (int j = 0; j < rows.length; j++){

            final user = rows[j];
            if (user[1].toLowerCase().substring(1,user[1].length-2).contains(splitted[i].toLowerCase()) && !jobMatched.contains(user[0]))
            {
              jobMatched.add(user[0]);
              jobMatchedAccm.add(user[1].toLowerCase().substring(1,user[1].length-4));
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
        body: Container(
          color: MyColors.myBackground,
          child: Center
          (
            child: widget.firsTime ? const Text("Finding Your Match!", style: TextStyle(fontSize: 50),)
            : const Text("Fetching Your Preferences", style: TextStyle(fontSize: 50),)
          ),
        )
      );
    }
    return Scaffold(
      body: Container(
        color: MyColors.myBackground,
        child: Center(
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
                      Expanded(child: Text("${jobMatched[index]}:   ${jobMatchedAccm[index]}", style: const TextStyle(fontSize: 20),)),
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