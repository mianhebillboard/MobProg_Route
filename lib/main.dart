import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirstPage()
    );
  }
}

class FirstPage extends StatefulWidget {

  String? userInput;

  FirstPage({this.userInput});

  @override
  State<FirstPage> createState() => FirstPageState();

}

class FirstPageState extends State<FirstPage> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('This is the First Page'),
            backgroundColor: Colors.blue
        ),
        body: Form(
            key: formKey,
            child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextFormField(
                    controller: textcontroller,
                    decoration: const InputDecoration(
                      labelText: 'Type something...',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    validator: (value) {
                      //clears the whitespaces in the beginning and end of input
                      value = (textcontroller.text).trim();
                      if (value ==''){
                        return 'Please input something';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo, // background
                      foregroundColor: Colors.white, // foreground
                    ),
                    onPressed: (){

                      formKey.currentState?.validate();

                      //asigns the input to a variable and clears the whitespaces in the beginning and end of input
                      widget.userInput = (textcontroller.text).trim();

                          (context) => SecondPage(userInput: widget.userInput);

                      textcontroller.clear();
                      setState(() {});
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondPage(userInput: widget.userInput),
                        ),
                      );
                      textcontroller.clear();
                      setState(() {});
                    },
                    child: const Text('Go to second page'),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    //clears the previous input
                      child : IconButton(
                        icon: const Icon(Icons.restore),
                        onPressed: (){
                          widget.userInput = null;
                          textcontroller.clear();
                          setState(() {});
                        },
                      )
                  )
                ]
            )
        )
    );
  }
}

class SecondPage extends StatefulWidget {

  String? userInput;

  SecondPage({this.userInput});

  @override
  State<SecondPage> createState() => SecondPageState();

}

class SecondPageState extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: const Text('This is the Second page')
        ),
        body: ListView (
            padding: const EdgeInsets.all(20),
            children: [
              if ((widget.userInput) == null || (widget.userInput) == '') const Text('You did not type anything.',
                  textAlign: TextAlign.center)
              else Text("You've inputted: ${widget.userInput}",
                  textAlign: TextAlign.center
              ),
              const SizedBox(height:20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // background
                    foregroundColor: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to first page')
              )

            ]
        )
    );
  }

}