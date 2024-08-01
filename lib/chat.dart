//import 'text2speech.dart';
//import 'package:googleapis_auth/auth_io.dart';
//import 'package:http/http.dart' as http;
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
  //bool _speechEnabled = false;
  String _lastWords = '';
  //final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initSpeech();
    //t2s.initTts();

    

    
  }



  // void _playAudio() async {
  //   AudioSource? _audioSource = AudioSource.uri(
  //     Uri.parse('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
  //   );
  //   if (_isPlaying) {
  //     await _audioPlayer.pause();
  //   } else {
  //     await _audioPlayer.play(_audioSource!);
  //   }
  //   setState(() {
  //     _isPlaying = !_isPlaying;
  //   });
  // }

  

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

  // Future<String> convertSpeechToText(String filePath) async{
  //   const apiKey = '';
  //   var url = Uri.http(
  //     "api.openai.com",
  //     "/v1/audio/transcriptions"
  //   );
  //   var request = http.MultipartRequest('POST', url);
  //   request.headers.addAll(({"Authorization":"Bearer $apiKey"}));
  //   request.fields["model"] = 'whisper-1';
  //   request.fields["language"] = "en";
  //   request.files.add(await http.MultipartFile.fromPath('file', filePath));
  //   var response = request.send();
  //   var 
  // }

  // void _speak(String text) async{
  //   try {
  //     await tts.speak(text);
  //   } catch (e) {
  //     print("Error speaking text: $e");
  //   }
  // }
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
      prompt: "You are interviewing me, and I say this, please respond in second person with an extremely specific question. For example, ask \"What specific courses or topics have you studied?\" or \"Can you describe a software project you are proud of?\" Also only ask one question in return per response.: ${promptController.text}",
      maxTokens: 400,
    );

    


    // setState(() => responseText = completion.choices[0].text);
    setState(() {
      responseText = completion.choices[0].text.trim();
      responses += "You: ${promptController.text}\n";
      responses += "Interviewer: $responseText\n";
    });
    _speak(completion.choices[0].text);
    print(completion.choices[0].text);
    // final voice = await OpenAI.instance.audio.createSpeech(
    //   model: "tts-1",
    //   voice: "alloy",
    //   input: completion.choices[0].text,
    //   //outputDirectory: Directory("audio"),
    //   outputFileName: "anas"
    // );

    // print (voice.path);

    // final player = AudioPlayer();
    // player.setFilePath("anas.mpeg");
    //player.play(player.source)
    //player.play();
    //final duration = await player.setAudioSource(AudioSource.)
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
  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late final TextEditingController promptController = TextEditingController();
  String responseText = '';
  String responses = "Interviewer: ...\n"; 
  
  @override
  Widget build(BuildContext context) {
    //print (responses.length);

    //_convertTextToSpeech("hey");
    requestPermission();
    //_playAudio();
    //double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.myBackground,
      appBar: AppBar(
        title: const Text(
          'Practice Job Interview With a Bot',
          style: TextStyle(color: MyColors.myOnPrimary ),
        ),
      ),
      body: isAudioInterview ? Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.person, size: 200),
            ),
            Row(
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
                  child: Icon(Icons.mic)
                ),
                SizedBox (width: 20,),
                Text(_lastWords)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: FittedBox(child: Text (responses, style: const TextStyle(color: MyColors.myOnPrimary,fontSize: 20)))
              ),
              // child: Column(
              //   children: [
              //     SizedBox(height: height / 5, child: FittedBox(child: Row(children: [const Text("Interviewer: ", style: TextStyle(color: MyColors.myOnPrimary,fontSize: 20)), PromptBldr(responseText: responseText,)]))),
              //     SizedBox(height: height / 5, child: FittedBox(child: Row(children: [Text("You: $_lastWords", style: const TextStyle(color: MyColors.myOnPrimary,fontSize: 20),),]))),
              //   ],
              // )
            )
          ]
        ),
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: FittedBox(child: Text (responses, style: const TextStyle(color: MyColors.myOnPrimary,fontSize: 20)))
          ),
          
          //PromptBldr(responseText: responseText,),
          TextFormFieldBldr(
            promptController: promptController, bitFun: textConversate,
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_convertTextToSpeech("hey");
          setState(() {
            isAudioInterview = !isAudioInterview;
          }); 
        },
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isAudioInterview ? Icon(Icons.message,) : Icon(Icons.mic),
            isAudioInterview ? Text("Text", style: TextStyle(fontSize: 7, color: Colors.black),) : Text("Audio", style: TextStyle(fontSize: 7, color: Colors.black)),
          ]
        )
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
        padding: const EdgeInsets.only(left:10,right: 10,bottom: 50),
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
