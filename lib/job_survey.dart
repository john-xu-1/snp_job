import 'package:flutter/material.dart';
import 'package:snp_job/pref_survey.dart';
import 'color_scheme.dart';
import 'sheetshelper.dart';

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

class JobSurvey extends StatefulWidget {
  const JobSurvey({Key? key, required this.email}) : super(key: key);

  final String email;
  @override
  State<JobSurvey> createState() => _JobSurveyState();
}



class _JobSurveyState extends State<JobSurvey> {
  String jobCompany = ""; 
  String jobPosition = ""; 


  Future<void> _submitSection() async {
    try {
      if (jobCompany != "" && jobPosition != "")
      {
        final sheet = await SheetsHelper.sheetSetup("database"); 
        final submission = [fullAccommodations]; 
        await sheet!.values.insertRowByKey ("$jobCompany: $jobPosition", submission);
      }
      //await sheet!.values.insertRowByKey (widget.email, submission, fromColumn: 4);
    } catch (e) {
      print('Error: $e');
    }
  }
  
  @override
  void initState() {
    super.initState();
  }

  void setCompany(String val){
    setState(() {
      jobCompany = val;
    });
  }

  void setPosition(String val){
    setState(() {
      jobPosition = val;
    });
  }
  

  String dropdownValue = "Sense of workplace community";
  String fullAccommodations = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("It would help us a lot if you could share your work accommodation experience (may leave bank)"),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffeebg.png'),
                                
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeatY,
              ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height / 4.5,
                //color: Colors.red[300],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(left: 15, bottom: 10), child: SizedBox(width: width/3 ,child: const Row(children: [ Text("Your Company",textScaleFactor: 1.5, textAlign: TextAlign.left,)]))),
                      SizedBox(
                        width: width /3,
                        child: TextFormField(
                          onChanged: (String value) { 
                            setState(() {
                              jobCompany = value;
                            });
                          },
                          cursorColor: const Color.fromARGB(255, 0, 0, 0),
                          //autofocus: true,
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
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
                            hintText: "Company name here",
                            hintStyle: TextStyle(color: MyColors.myOnPrimary),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 4.5,
                //color: Colors.red[300],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(left: 15, bottom: 10), child: SizedBox(width: width/3 ,child: const Row(children: [ Text("Your Position",textScaleFactor: 1.5, textAlign: TextAlign.left,)]))),
                      SizedBox(
                        width: width /3,
                        child: TextFormField(
                          onChanged: (String value) { 
                            setState(() {
                              jobPosition = value;
                            });
                          },
                          cursorColor: const Color.fromARGB(255, 0, 0, 0),
                          //autofocus: true,
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
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
                            hintText: "Position name here",
                            hintStyle: TextStyle(color: MyColors.myOnPrimary),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              const Text("Did your job offer any of the following accomodations?", style: TextStyle(fontSize: 20),),
              Container(
                padding: const EdgeInsets.all(15),
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 5, color: MyColors.myOnPrimary), ), child: Padding(padding: const EdgeInsets.all(7.5), child: Text("Accommodations added: $fullAccommodations", style: const TextStyle(fontSize: 20))))
              ),
              SizedBox(
                width: width / 3,
                child: DropdownButton(
                  alignment: Alignment.center,
                  value: dropdownValue,
                  dropdownColor: MyColors.myBackground,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
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
                      child: Text(value),//SizedBox(width: width/3.5, child: FittedBox(child: Text(value))),
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () 
                    {
                      _submitSection();
                
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => PrefSurvey(email: widget.email,)//Home(loggedInEmail: widget.email,)
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