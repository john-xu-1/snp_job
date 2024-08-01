import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'signup.dart';
import 'login.dart';
import 'chat.dart';
import 'job_matches.dart';

class OurServices extends StatefulWidget {
  const OurServices({super.key, required this.loggedInEmail, required this.accommodations});

  final String loggedInEmail;
  final String accommodations;

  @override
  State<OurServices> createState() => _OurServicesState();
}

bool hoverSignup = false;
bool hoverLogin = false;

class _OurServicesState extends State<OurServices> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 222, 222),
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: ExactAssetImage("assets/infinitylogo.png"))),
          ),
        ),
        actions: [
          if (widget.loggedInEmail == "")
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColors.myOnPrimary),
                        color: hoverLogin
                            ? MyColors.myOnBackgroundD
                            : const Color.fromARGB(0, 255, 255, 255)),
                    child: TextButton(
                      onHover: (bool value) {
                        setState(() {
                          hoverLogin = value;
                        });
                      },
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()));
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(color: MyColors.myOnSurface),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 80,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColors.myOnPrimary),
                        color: hoverSignup
                            ? MyColors.myOnBackgroundD
                            : const Color.fromARGB(0, 255, 255, 255)),
                    child: TextButton(
                      onHover: (bool value) {
                        setState(() {
                          hoverSignup = value;
                        });
                      },
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: MyColors.myOnSurface),
                      ),
                    ),
                  )
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.person),
            )
        ],
        elevation: 21,
      ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 229, 219, 217), // Set the background color here
          child: ListView(
            children: <Widget>[
              Container(
                height: height / 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExactAssetImage("assets/work.png"))),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Neu-Link",
                          style: TextStyle(fontSize: 75),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) {
                                    if (widget.loggedInEmail == "") return SignUp();
                                    return JobMatches(
                                      email: widget.loggedInEmail,
                                      accommodations: widget.accommodations,
                                      firsTime: false,
                                    );
                                  }));
                            },
                            child: widget.loggedInEmail == ""
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 5,
                                            color: MyColors.myOnPrimary)),
                                    child: const Padding(
                                        padding: EdgeInsets.all(7.5),
                                        child: Text("Start Finding",
                                            style: TextStyle(fontSize: 20))))
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 5,
                                            color: MyColors.myOnPrimary)),
                                    child: const Padding(
                                        padding: EdgeInsets.all(7.5),
                                        child: Text("Check My Match",
                                            style: TextStyle(fontSize: 20)))))
                      ]),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                color: MyColors.myOnBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Our Mission",
                      style: TextStyle(fontSize: 50),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Text(
                        "At Neu-Link, we offer qualified autistic job seekers help with job seeking by providing accommodation info of companies and a machine learning chatbot that trains users so that they can succeed in their job interviews. We achieve this by following our four principles on the left.",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                color: MyColors.myOnBackground, // Match background color with "Our Mission" section
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "The Issue",
                      style: TextStyle(fontSize: 50),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: const [
                                    Text(
                                      "87%",
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                    Text(
                                      "of autistic adults in the US are unemployed or underemployed.",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: const [
                                    Text(
                                      "44%",
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                    Text(
                                      "of autistic individuals reported not being in employment that suited their skills and abilities.",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "AUTISTIC WORKERS WERE 90% MORE PRODUCTIVE THAN NON-AUTISTIC EMPLOYEES. WHEN MATCHED TO PROJECTS THEY WERE PASSIONATE ABOUT, THEIR PRODUCTIVITY SOARED TO 140% ABOVE THAT OF THEIR NON-AUTISTIC COUNTERPARTS. -JP Morgan Chase",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Chat()));
          },
          child: SizedBox(
            height: height / 10,
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat,
                    size: 50,
                  ),
                  Text(
                    "Interview Practice",
                  )
                ]),
          )),
    );
  }
}
