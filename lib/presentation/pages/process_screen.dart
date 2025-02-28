import 'package:flutter/material.dart';

class ProcessScreen extends StatefulWidget{
  const ProcessScreen({super.key});

  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Process screen',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white)),
              backgroundColor: Colors.lightBlue,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text (
                    'All calculations has finished, you can send you results to server',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProcessScreen()),
                        );
                      },
                      child: const Text(
                        'Send results to server',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ));
  }
}
