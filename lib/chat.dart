//import 'text2speech.dart';
//import 'package:googleapis_auth/auth_io.dart';
//import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:dart_openai/dart_openai.dart';
import 'color_scheme.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import 'package:text_to_speech/text_to_speech.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'dart:html';
//import 'text2speech.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:js' as js;


//import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers_web/audioplayers_web.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

bool isStart = false;
//String? path = "";
class _ChatState extends State<Chat> {
  bool isAudioInterview = false;

  //Text2Speech tts = Text2Speech();
  final FlutterTts tts = FlutterTts();
  //TextToSpeech tts = TextToSpeech();
   
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';


  late final TextEditingController promptController = TextEditingController();
  late final ScrollController _scrollController = ScrollController();
  String responseText = '';
  String responses = "Interviewer: ...\n"; 
  List<Widget> chats = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _initSpeech();
    chats.add(
      const Text('Interviewer: Hi, are you ready?')
    );
    //t2s.initTts();

    

    
  }



  

  Future<void> requestPermission() async {
    //await window.navigator.requestMediaKeySystemAccess(keySystem, supportedConfigurations)
    await window.navigator.getUserMedia(audio: true, video: false);
    final perm =
        await window.navigator.permissions?.query({"name": "camera"});      
    const permission = Permission.microphone;
    const permission2 = Permission.speech;
    const permission3 = Permission.audio;

    if (await permission.isDenied) {
      await permission.request();
    }
    if (await permission2.isDenied) {
      await permission2.request();
    }
    if (await permission3.isDenied) {
      await permission3.request();
    }
  }

  void _initSpeech() async {
    await _speechToText.initialize();
  
    
    setState(() {});
  }

  void _startListening() async {
    try{
      await _speechToText.listen(onResult: _onSpeechResult);
    }
    catch (e){
      print (e);
    }
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    print (_lastWords);
    responses += "You: $_lastWords\n";
    _lastWords = "";
    audioConversate();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    
  }

  void _speak(String text){
    try{
      js.context.callMethod('speakText', [text]);
    }
    catch (e){
      print (e);
    }
    

  }

  


  

  Future<void> textConversate() async {
    OpenAI.apiKey = "sk-svcacct-Jm8pi8vif5SvOQmdNvD6T3BlbkFJkfBe9h1mUzZ6rGglmX0V";
    final completion = await OpenAI.instance.completion.create(
      model: "gpt-3.5-turbo-instruct",
      prompt: "You are interviewing me, and I say this, please respond in second person with an extremely specific question. For example, ask \"What specific courses or topics have you studied?\" or \"Can you describe a software project you are proud of?\" Also only ask one question in return per response.: ${promptController.text}\n",
      maxTokens: 400,
    );
    setState(() {
      responseText = completion.choices[0].text.trim();
      
      chats.add(
        Text(
          "You: ${promptController.text}",
          textAlign: TextAlign.center,
        )
      );
      chats.add(
        Text(
          "Interviewer: $responseText"
        )
      );
      responses += "You: ${promptController.text}\n";
      responses += "Interviewer: $responseText\n";
    });
    _speak(completion.choices[0].text);
    print (_scrollController.initialScrollOffset);
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut
    );
    print(completion.choices[0].text);
    promptController.text = "";
  }

  Future<void> audioConversate() async {
    OpenAI.apiKey = "sk-svcacct-Jm8pi8vif5SvOQmdNvD6T3BlbkFJkfBe9h1mUzZ6rGglmX0V";
    final completion = await OpenAI.instance.completion.create(
      model: "gpt-3.5-turbo-instruct",
      prompt: "You are interviewing me, and I say this, please respond in second person with an extremely specific question. For example, ask \"What specific courses or topics have you studied?\" or \"Can you describe a software project you are proud of?\" Also only ask one question in return per response.: $_lastWords",
      maxTokens: 400,
    );

    setState(() {
      responseText = completion.choices[0].text.trim();
      responses += "Interviewer: $responseText\n";
    });

    _speak(completion.choices[0].text);
    print(completion.choices[0].text);
  }


  

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
    //tts.stop();
    promptController.dispose();
  }
  // /// Scaffold Key
  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  

  

  
  @override
  Widget build(BuildContext context) {
    requestPermission();
    //_playAudio();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.myBackground,
      appBar: AppBar(
        title: const Text(
          'Practice Job Interview With a Bot',
          style: TextStyle(color: MyColors.myOnPrimary ),
        ),
        actions: [
          IconButton(
             onPressed: () {
              //_convertTextToSpeech("hey");
              setState(() {
                isAudioInterview = !isAudioInterview;
              }); 
            },
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 2.5,
                    color: MyColors.myBackground)
              ),
              width: width/7,
              child: Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isAudioInterview ? Icon(Icons.message, color: MyColors.myBackground) : Icon(Icons.mic, color: MyColors.myBackground),
                  const SizedBox (width: 7,),
                  isAudioInterview ? Text("Text",) : Text("Audio",),
                ]
              ),
            )
          )
        ],
      ),
      body: isAudioInterview 
      ? Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.person, size: 200),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: ()
                  {
                    if (isStart) {
                      _stopListening();
                    } else {
                      _startListening();
                    }
                    isStart = !isStart;
                  }, 
                  child: const Icon(Icons.mic)
                ),
                const SizedBox (width: 20,),
                SingleChildScrollView(child: Expanded(child: SizedBox(width: width * 0.9, child: Text(_lastWords))))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Expanded(
                  child: Container(
                    width: width * 0.8,
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 2.5,
                          color: MyColors.myOnPrimary)
                    ),
                    child: SingleChildScrollView(child: Text (responses, style: const TextStyle(color: MyColors.myOnPrimary,fontSize: 20))))
                )
              ),
            )
          ]
        ),
      ) 
      : Container(
        height: height,
        decoration: const BoxDecoration(
          color: MyColors.myPrimaryColor,
          image: DecorationImage(
            image: ExactAssetImage('assets/coffeebg.png'),
            alignment: Alignment.centerLeft,
            repeat: ImageRepeat.repeatY,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SingleChildScrollView(
            //   child: FittedBox(child: Text (responses, style: const TextStyle(color: MyColors.myOnPrimary,fontSize: 20)))
            // ),
        
            IntrinsicHeight(
              child: Row(
                children: [
                  SizedBox(width: width * 0.2,),
                  // Padding(
                  //   padding: EdgeInsets.only(top: height/9, ),
                  //   child: const VerticalDivider(thickness: 2, color: MyColors.mySurface),
                  // ),
                  Container(
                    //color: Color.fromARGB(65, 255, 255, 255),
                    height: height * 0.8,
                    width: width * 0.8,
                    //color: Colors.black,
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: chats.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: height/8,
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: index % 2 == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                            children: [
                              index % 2 == 0 ? 
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container( 
                                  decoration: BoxDecoration(
                                    color: MyColors.myOnPrimary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.person, size: 40)
                                ),
                              )
                              : SizedBox(),
                              SizedBox(
                                width: width / 4,
                                child: Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2.5,
                                          color: Colors.black)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(child: chats[index]),
                                    ),
                                  ),
                                ),
                              ),
                              index % 2 != 0 
                              ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container( 
                                  decoration: BoxDecoration(
                                    color: MyColors.myOnBackgroundD,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.person, size: 40)
                                ),
                              ) 
                              : SizedBox(),
                              //const SizedBox(width: 20,),
                              //Text(jobMatchedAccm[index], style: const TextStyle(fontSize: 20),),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => 
                      SizedBox()
                        
                    ),
                  ),
                ],
              ),
            ),
            //PromptBldr(responseText: responseText,),
            IntrinsicHeight(
              child: Row(
                children: [
                  SizedBox (width: width*0.2,),
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: VerticalDivider(thickness: 2, color: MyColors.mySurface),
                  // ),
                  SizedBox(
                    width: width * 0.8,
                    child: TextFormFieldBldr(
                      promptController: promptController, bitFun: textConversate,
                    ),
                  ),
                ],
              ),
            ),
        
          ],
        ),
      ),

    );
  }

}


class TextFormFieldBldr extends StatelessWidget{
  const TextFormFieldBldr(
    {super.key, required this.promptController, required this.bitFun});
  final TextEditingController promptController;
  final Function bitFun;
  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left:10,right: 10,),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                cursorColor: const Color.fromARGB(255, 0, 0, 0),
                controller: promptController,
                autofocus: true,
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
                  fillColor: MyColors.myOnPrimary,
                  hintText: 'Write your response here',
                  hintStyle: TextStyle(color: MyColors.myBackground),
                ),
              )
            ),
            Container(
              color:MyColors.myBackground,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {
                    bitFun();
                  },
                  icon: const Icon(Icons.send),
                )
              ),
            )
          ]
        ),
      ),
    );
  }
}

class PromptBldr extends StatelessWidget{
  const PromptBldr({
    super.key,
    required this.responseText,
  });
  final String responseText;

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      //height: he,
      color: MyColors.myOnBackground,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: FittedBox(
            child: Text(
              responseText.isEmpty ? "..." : responseText.trim(),
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 25, color: MyColors.myOnPrimary),
              softWrap: true,
            ),
          ),
        )
      )
      
    );
  }
}
