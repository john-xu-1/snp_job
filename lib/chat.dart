import 'text2speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:wakelock/wakelock.dart';
import 'package:dart_openai/dart_openai.dart';
import 'color_scheme.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

bool isStart = false;
//String? path = "";
class _ChatState extends State<Chat> {
  bool isAudioInterview = false;

  Text2Speech t2s = Text2Speech();
  final SpeechToText _speechToText = SpeechToText();
  //bool _speechEnabled = false;
  String _lastWords = '';
  List<ResultObjectDetection?>? results;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    t2s.initTts();
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
    audioConversate();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    
  }


  // void _startRecording() async {
  //   if (await record.hasPermission()) {
  //     // final Directory appDocumentDir = await getApplicationCacheDirectory();
  //     // final String filePath = p.join(appDocumentDir.path, "audio.wav");
  //     await record.start(const RecordConfig(), path: "audio.wav");
  //   } 
  // }

  // Future<String> transcribe(String path) async{
  //   final apiKey = 'sk-svcacct-Jm8pi8vif5SvOQmdNvD6T3BlbkFJkfBe9h1mUzZ6rGglmX0V';
  //   final url = 'https://api.openai.com/v1/audio/transcriptions';

  //   try {
  //   final dio = Dio();
  //   //final file = File(path); // Use if targeting mobile or desktop

  //   final formData = FormData.fromMap({
  //     'model': 'whisper-1',
  //     'file': await MultipartFile.fromFile(path), // Use filePath directly
  //   });

  //   final response = await dio.post(
  //     url,
  //     data: formData,
  //     options: Options(
  //       headers: {
  //         'Authorization': 'Bearer $apiKey',
  //         'Content-Type': 'multipart/form-data',
  //       },
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     return response.data.toString(); // Adjust according to actual response structure
  //   } else {
  //     throw Exception('Failed to transcribe audio');
  //   }
  // } catch (e) {
  //   throw Exception('Error transcribing audio: $e');
  // }
  // }


  // Future<void> _stopRecording() async {
  //   final String? path = await record.stop();
  //   //print (path);
  //   //File audioFile = File(path!);
  //   try {
  //     final transcription = await transcribe(path!);
  //     print('Transcription: $transcription');
  //     // Display or handle transcription here
  //   } catch (e) {
  //     print('Error transcribing audio: $e');
  //   }

  //   // final transcription = await OpenAI.instance.audio.createTranscription(
  //   //   file: audioFile,
  //   //   model: "whisper-1",
  //   // );
  //   //print (transcription.text);
    
  // }

  

  

  Future<void> textConversate() async {
    OpenAI.apiKey = "sk-svcacct-Jm8pi8vif5SvOQmdNvD6T3BlbkFJkfBe9h1mUzZ6rGglmX0V";
    final completion = await OpenAI.instance.completion.create(
      model: "gpt-3.5-turbo-instruct",
      prompt: "You are interviewing me, and I say this, please respond in second person with an extremely specific question. For example, ask \"What specific courses or topics have you studied?\" or \"Can you describe a software project you are proud of?\" Also only ask one question in return per response.: ${promptController.text}",
      maxTokens: 400,
    );

    setState(() => responseText = completion.choices[0].text);
    t2s.speak(completion.choices[0].text);
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

    setState(() => responseText = completion.choices[0].text);
    t2s.speak(completion.choices[0].text);
    print(completion.choices[0].text);
  }

  

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
    t2s.stop();
    promptController.dispose();
  }
  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late final TextEditingController promptController = TextEditingController();
  String responseText = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myBackground,
      appBar: AppBar(
        title: const Text(
          'Job Interview',
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
            )

          ]
        ),
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PromptBldr(responseText: responseText,),
          TextFormFieldBldr(
            promptController: promptController, bitFun: textConversate,
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isAudioInterview = !isAudioInterview;
          }); 
        }
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
                  onPressed: () => bitFun(),
                  icon: const Icon(Icons.add_comment),
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
      height: 300,
      color: MyColors.myBackground,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Text(
            responseText,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 10, color: MyColors.myOnPrimary),
          ),
        )
      )
    );
  }
}
