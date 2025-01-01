import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';
  @override
  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
  }

  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Assistant'),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: Stack(
        children: [
          Text("Chat messages will be displayed here"),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Type a message',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            speechToText.isNotListening
                                ? startListening()
                                : stopListening();
                          },
                          icon: Icon(speechToText.isNotListening
                              ? Icons.mic_off
                              : Icons.mic),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
