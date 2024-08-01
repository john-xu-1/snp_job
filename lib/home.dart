import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'color_scheme.dart';
import 'signup.dart';
import 'login.dart';
import 'chat.dart';
import 'jobmatches.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.loggedInEmail, required this.accommodations});

  final String loggedInEmail;
  final String accommodations;

  @override
  State<Home> createState() => _HomeState();
}

bool hoverSignup = false;
bool hoverLogin = false;

class _HomeState extends State<Home> {
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
          color: const Color.fromARGB(255, 229, 219, 217),
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
                          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const Text(
                          "Find the perfect job",
                          style: TextStyle(fontSize: 24, color: Colors.white),
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
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white, // White box
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 173, 216, 230), // Light blue shadow
                                  offset: const Offset(3, 3), // Offset for bottom-right shadow
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "IDENTIFY",
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 243, 176, 88)),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "TRAIN",
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 243, 176, 88)),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "EMPOWER",
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 243, 176, 88)),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "MATCH",
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 243, 176, 88)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 2,
                                  child: const Text(
                                    "At Neu-Link, we offer qualified autistic job seekers help with job seeking by providing accommodation info of companies and a machine learning chatbot that trains users so that they can succeed in their job interviews. We achieve this by following our four principles on the left.",
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "connect",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 143, 163, 128)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                color: MyColors.myOnBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "The Issue",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white, // White box
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 173, 216, 230), // Light blue shadow
                            offset: const Offset(3, 3), // Offset for bottom-right shadow
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                              value: 87,
                                              color: Colors.orange,
                                              radius: 75,
                                              showTitle: false,
                                            ),
                                            PieChartSectionData(
                                              value: 13,
                                              color: Colors.grey.withOpacity(0.3),
                                              radius: 75,
                                              showTitle: false,
                                            ),
                                          ],
                                          startDegreeOffset: 270,
                                          borderData: FlBorderData(show: false),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 0,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "87%",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "of autistic adults in the US are unemployed or underemployed.",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                              value: 44,
                                              color: Colors.blue,
                                              radius: 75,
                                              showTitle: false,
                                            ),
                                            PieChartSectionData(
                                              value: 56,
                                              color: Colors.grey.withOpacity(0.3),
                                              radius: 75,
                                              showTitle: false,
                                            ),
                                          ],
                                          startDegreeOffset: 270,
                                          borderData: FlBorderData(show: false),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 0,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "44%",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "of autistic adults in the US have no high school or college diploma.",
                                  style: TextStyle(fontSize: 20),
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
              Container(
                padding: const EdgeInsets.all(12.0),
                color: MyColors.myBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "AUTISITIC WORKERS WERE\n90% MORE PRODUCTIVE THAN NON-AUTISTIC EMPLOYEES.\nWHEN MATCHED TO PROJECTS\nTHEY WERE PASSIONATE ABOUT, THEIR PRODUCTIVITY SOARED TO 140% ABOVE THAT OF THEIR NON-AUTISTIC COUNTERPARTS.\n-JP Morgan Chase",
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Build an Inclusive Future",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Join us in creating job opportunities for everyone!",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
