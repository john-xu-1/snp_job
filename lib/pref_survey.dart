import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';
import 'job_matches.dart';

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

class PrefSurvey extends StatefulWidget {
  const PrefSurvey({Key? key, required this.email}) : super(key: key);

  final String email;
  @override
  State<PrefSurvey> createState() => _PrefSurveyState();
}



class _PrefSurveyState extends State<PrefSurvey> {

  Future<void> _submitSection() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("login info"); 
      final submission = [fullAccommodations]; 
      await sheet!.values.insertRowByKey (widget.email, submission, fromColumn: 4);
    } catch (e) {
      print('Error: $e');
    }
  }
  
  @override
  void initState() {
    super.initState();
  }
  

  String dropdownValue = "Sense of workplace community";
  String fullAccommodations = "";

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's Start Job Matching"),
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
            children: [
              const Text("Select the accommodations you need below:", style: TextStyle(fontSize: 20),),
              Container(
                padding: const EdgeInsets.all(15),
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 5, color: MyColors.myOnPrimary), ), child: Padding(padding: const EdgeInsets.all(7.5), child: Text("Your accommodations: $fullAccommodations", style: const TextStyle(fontSize: 20)))),
              ),
              SizedBox(
                width: width / 3,
                child: DropdownButton(
                  alignment: Alignment.center,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  dropdownColor: MyColors.myBackground,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: MyColors.myOnPrimary,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                      if (!fullAccommodations.contains(value)) fullAccommodations += "$value, ";
                    });
                  },
                  items: accommodations.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      alignment: Alignment.center,
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _submitSection();
                
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => JobMatches(email: widget.email, accommodations: fullAccommodations, firsTime: true,)//Home(loggedInEmail: widget.email,)
                        )
                      );
                    },
                    child: const Icon(Icons.send),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () 
                    {
                      setState(() {
                        fullAccommodations = "";
                      });
                    },
                    child: const Icon(Icons.delete),
                  )
                ]
              ),
            ],
          ),
        )
      ),
    );
  }
}