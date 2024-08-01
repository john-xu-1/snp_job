import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';
import 'job_matches.dart';

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
                style: const TextStyle(color: MyColors.myOnPrimary),
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
        )
      ),
    );
  }
}