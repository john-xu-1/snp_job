import 'text2speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:wakelock/wakelock.dart';
import 'package:dart_openai/dart_openai.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Text2Speech t2s = Text2Speech();
  List<ResultObjectDetection?>? results;
  String? classification;

  @override
  void initState() {
    super.initState();
    t2s.initTts();
  }

  Future<void> test() async {
    
    
    // Set the OpenAI API key from the .env file.
    OpenAI.apiKey = "sk-svcacct-Jm8pi8vif5SvOQmdNvD6T3BlbkFJkfBe9h1mUzZ6rGglmX0V";

    // Start using!
    final completion = await OpenAI.instance.completion.create(
      model: "text-davinci-003",
      prompt: promptController.text,
      maxTokens: 400,
    );

    // Printing the output to the console
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
    t2s.speak("How are you feeling?");
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 255, 239),
      appBar: AppBar(
        title: const Text(
          'How are you feeling?',
          style: TextStyle(color: Color.fromARGB(255, 0, 92, 57) ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PromptBldr(responseText: responseText,),
          TextFormFieldBldr(
            promptController: promptController, bitFun: test,
          )

        ],
      )

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
                cursorColor: Colors.white,
                controller: promptController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 30, 151, 104),
                    ),
                    //borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:Color.fromARGB(255, 30, 151, 104)
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 30, 151, 104),
                  hintText: 'What do you need help with?',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              )
            ),
            Container(
              color:const Color.fromARGB(255, 157, 216, 194),
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
      color: const Color.fromARGB(255, 214, 255, 239),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Text(
            responseText,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 30, 151, 104)),
          ),
        )
      )
    );
  }
}
