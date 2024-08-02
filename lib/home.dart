import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'color_scheme.dart';
import 'signup.dart';
import 'login.dart';
import 'job_matches.dart';
import 'chat.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.loggedInEmail, required this.accommodations});

  final String loggedInEmail;
  final String accommodations;

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  double _animationProgress = 0.0;
  double _opacityOurMission = 0.0;
  double _opacityTheIssue = 0.0;
  bool hoverSignup = false;
  bool hoverLogin = false;
  bool hoverChatbot = false;

  void _animateOurMission() {
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacityOurMission = 1.0;
      });
    });
  }

  void _animateCharts(){
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacityTheIssue = 1.0;
        _animationProgress = 1.0;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    //_animateOurMission();
    

    
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    print (width);
    print (height);

    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 222, 222),
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: ExactAssetImage("assets/infinitylogo.png")
              )
            ),
          ),
        ),
        actions: [
          if (widget.loggedInEmail == "")
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Container(
                    width: 90,
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
                    width: 90,
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
                height: height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: ExactAssetImage("assets/work.png")
                  )
                ),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Neu-Link",
                          style: TextStyle(fontSize: 100, color: Colors.white),
                        ),
                        // const Text(
                        //   "Find the perfect job",
                        //   style: TextStyle(fontSize: 24, color: Colors.white),
                        // ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) {
                                        if (widget.loggedInEmail == "") return const SignUp();
                                        return JobMatches(
                                          email: widget.loggedInEmail,
                                          accommodations: widget.accommodations,
                                          firsTime: false,
                                        );
                                      }
                                  )
                              );
                            },
                            child: widget.loggedInEmail == ""
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 5,
                                            color: MyColors.myPrimaryColor)),
                                    child: const Padding(
                                        padding: EdgeInsets.all(7.5),
                                        child: Text("Find the perfect job",
                                            style: TextStyle(fontSize: 20, color: MyColors.myPrimaryColor))))
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 5,
                                            color: MyColors.myPrimaryColor)),
                                    child: const Padding(
                                        padding: EdgeInsets.all(7.5),
                                        child: Text("Check My Matches",
                                            style: TextStyle(fontSize: 20, color: MyColors.myPrimaryColor)))))
                        ]
                    ),
                ),
              ),
              Container(
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/coffeebg.png'),
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.repeatY,
                    ),
                ),


                child: Column(
                  children: [
                    SizedBox (height: height / 23), 
                    VisibilityDetector(
                      key: const Key('our mission'),
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction > 0.3) {
                          _animateOurMission();
                        }
                      },
                      child: AnimatedOpacity(
                        opacity: _opacityOurMission,
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 500),
                        child: Stack( key: Key('our mission'),
                          children: [
                            Column(
                              children: [
                                SizedBox (height: height / 7),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width/1.3,
                                      height: height / 2.5,
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        color: Colors.white, // White box
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 173, 216, 230), // Light blue shadow
                                            offset: Offset(15, 15), // Offset for bottom-right shadow
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
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
                                          Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: VerticalDivider(),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SingleChildScrollView(
                                              child: Text(
                                                '''At Neu-Link, we offer qualified autistic job seekers help with job seeking by providing accommodation info of companies and a machine learning chatbot that trains users so that they can succeed in their job interviews. We achieve this by following our four principles on the left.''',
                                                style: TextStyle(fontSize: 30),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: width / 2,
                                decoration:
                                  const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                                  color: MyColors.myOnBackgroundD,
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      "Our Mission",
                                      style: TextStyle(fontSize: 50, color: Colors.white),
                                      //textScaler: TextScaler.linear(width / 1440)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height: height/7,),
                    VisibilityDetector(
                      key: const Key('the issue'),
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction > 0.3) {
                          _animateCharts();
                        }
                      },
                      child: AnimatedOpacity( key: const Key('the issue'),
                        opacity: _opacityTheIssue,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 500),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: height/7,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: width/1.3,
                                      height: height/2.5,
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        color: Colors.white, // White box
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 173, 216, 230), // Light blue shadow
                                            offset:  Offset(15, 15), // Offset for bottom-right shadow
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
                                                      TweenAnimationBuilder(
                                                        tween: Tween<double>(begin: 0, end: _animationProgress),
                                                        duration: const Duration(seconds: 2),
                                                        curve: Curves.easeIn,
                                                        builder: (context, double value, child) {
                                                          // print (value);
                                                          // print (_animationProgress);
                                                          return PieChart(
                                                            PieChartData(
                                                              sections: showingGraph1Sections(value),
                                                              startDegreeOffset: 270,
                                                              borderData: FlBorderData(show: false),
                                                              sectionsSpace: 0,
                                                              centerSpaceRadius: 0,
                                                            ),
                                                            // swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                                                            // swapAnimationCurve: Curves.linear,
                                                          );
                                                        }
                                                      ),
                                                      const Center(
                                                        child: Text(
                                                          "87%",
                                                          style: TextStyle(
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
                                                SizedBox(
                                                  width: width / 3.5,
                                                  height: height / 10,
                                                  child: const FittedBox(
                                                    child: Text(
                                                      "of autistic adults in the US are unemployed or underemployed.",
                                                      style: TextStyle(fontSize: 20),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
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
                                                      TweenAnimationBuilder(
                                                        tween: Tween<double>(begin: 0, end: _animationProgress),
                                                        duration: const Duration(seconds: 2),
                                                        curve: Curves.easeIn,
                                                        builder: (context, double value, child) {
                                                          // print (value);
                                                          // print (_animationProgress);
                                                          return PieChart(
                                                            PieChartData(
                                                              sections: showingGraph2Sections(value),
                                                              startDegreeOffset: 270,
                                                              borderData: FlBorderData(show: false),
                                                              sectionsSpace: 0,
                                                              centerSpaceRadius: 0,
                                                            ),
                                                          );
                                                        }
                                                      ),
                                                      const Center(
                                                        child: Text(
                                                          "44%",
                                                          style: TextStyle(
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
                                                SizedBox(
                                                  width: width / 3.5,
                                                  height: height / 10,
                                                  child: const FittedBox(
                                                    child: Text(
                                                      "of autistic adults in the US have no high school or college diploma.",
                                                      style: TextStyle(fontSize: 20),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width/1.3,
                              height: height / 6,
                              //color: Colors.black,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onHover: (bool value) {
                                      setState(() {
                                        hoverChatbot = value;
                                      });
                                    },
                                    onPressed: (){
                                      //print ("hi");
                                      Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => const Chat())
                                      );
                                    }, 
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Column(
                                        children: [
                                          const Text("Click to Practice Interview", style: TextStyle(color:Colors.black)),
                                          SizedBox(
                                            width: 0.055555555555556 * width,
                                            height: 0.113314447592068 * height,
                                            child: hoverChatbot 
                                            ? Image.asset("assets/chatbothi.png", alignment: Alignment.topCenter,)
                                            : Image.asset("assets/chatbotsit.png", alignment: Alignment.topCenter,)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //SizedBox(width: width/3,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: width / 2,
                                      decoration:
                                        const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                                        color: MyColors.myOnBackgroundD,
                                      ),
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text(
                                            "The Issue",
                                            style: TextStyle(fontSize: 50, color: Colors.white),
                                            //textScaler: TextScaler.linear(width / 1440)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                
                    SizedBox(height: height/10,),
                    Container(
                      width: width,
                      color: MyColors.myOnBackground,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                    ),
                
                  ],
                ),
              ),

              
              // Container(
              //   padding: const EdgeInsets.all(12.0),
              //   color: MyColors.myBackground,
              //   child: const 
              // ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingGraph1Sections(double animationValue) {
    return [
      PieChartSectionData(
        color: MyColors.myOnPrimary,
        value: 87 * animationValue,
        //title: '${(87 * animationValue).toInt()}%',
        showTitle: false,
        radius: 75,
        titleStyle: TextStyle(
            fontSize: 16 * animationValue, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      ),
      PieChartSectionData(
        color: MyColors.myBackground,
        value: 13,
        //title: '${(13 * animationValue).toInt()}%',
        showTitle: false,
        radius: 75,
        titleStyle: TextStyle(
            fontSize: 16 * animationValue, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      ),
    ];
  }
  List<PieChartSectionData> showingGraph2Sections(double animationValue) {
    return [
      PieChartSectionData(
        color: MyColors.myOnPrimary,
        value: 44 * animationValue,
        //title: '${(87 * animationValue).toInt()}%',
        showTitle: false,
        radius: 75,
        titleStyle: TextStyle(
            fontSize: 16 * animationValue, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      ),
      PieChartSectionData(
        color: MyColors.myBackground,
        value: 56,
        //title: '${(13 * animationValue).toInt()}%',
        showTitle: false,
        radius: 75,
        titleStyle: TextStyle(
            fontSize: 16 * animationValue, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      ),
    ];
  }
}
