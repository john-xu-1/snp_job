import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: OurServices(
      loggedInEmail: "",
      accommodations: "",
    ),
  ));
}

class OurServices extends StatelessWidget {
  final String loggedInEmail;
  final String accommodations;

  OurServices({required this.loggedInEmail, required this.accommodations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEADDD8),
      appBar: AppBar(
        title: Text('Our Services'),
        backgroundColor: Color(0xFFC1A29E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16),
              serviceSection(
                '01',
                'assets/identify.jpg',
                'We IDENTIFY our user’s list of accommodations by matching what they select on our accommodation form to jobs that align',
                textLeft: true,
              ),
              serviceSection(
                '02',
                'assets/train.jpg',
                'We help TRAIN our users for workplace transition and the job interview process using our AI chatbot to simulate a real life interview',
                textLeft: false,
              ),
              serviceSection(
                '03',
                'assets/empower.jpg',
                'We connect mentors/role models to our autistic users to give advice, resources, and EMPOWER. We believe mentorship is crucial assistance in the job hunting process.',
                textLeft: true,
              ),
              serviceSection(
                '04',
                'assets/match.jpg',
                'We MATCH our autistic users to jobs that have the accommodations they are looking for.',
                textLeft: false,
              ),
              SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Text(
                      'More Resources',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- Our AI chat bot, TIM',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '- Navigating hidden curriculums in the workplace',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '- Mentor Hub',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Contact Us: email@gmail.com',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceSection(String number, String imagePath, String description, {bool textLeft = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: textLeft
            ? [
                buildTextBox(description),
                buildImageBox(number, imagePath, leftRounded: true),
              ]
            : [
                buildImageBox(number, imagePath, leftRounded: false),
                buildTextBox(description),
              ],
      ),
    );
  }

  Widget buildTextBox(String description) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildImageBox(String number, String imagePath, {bool leftRounded = true}) {
    return Expanded(
      flex: 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(leftRounded ? 100.0 : 0.0),
              bottomLeft: Radius.circular(leftRounded ? 100.0 : 0.0),
              topRight: Radius.circular(leftRounded ? 0.0 : 100.0),
              bottomRight: Radius.circular(leftRounded ? 0.0 : 100.0),
            ),
            child: Container(
              height: 400,
              color: Color(0xFF89A38A),
              padding: EdgeInsets.all(16.0),
              child: Image.asset(imagePath, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/placeholder.jpg', fit: BoxFit.cover);
              }),
            ),
          ),
          Positioned(
            top: -40,
            left: leftRounded ? null : 0,
            right: leftRounded ? 0 : null,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
