import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webspark_test_task/presentation/pages/process_screen.dart';
import '../../data/data_sources/local/preferences_helper.dart';
import '../../domain/use_cases/save_url_use_case.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlInputController = TextEditingController();
  final saveUrlUseCase = SaveServerUrlUseCase(PreferencesHelper.instance);

  void _saveUrl() async {
    if(_urlInputController.text != '') {
      await saveUrlUseCase.execute(_urlInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    });
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Home screen',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),),
              backgroundColor: Colors.lightBlue,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text (
                    'Set valid API base URL in order to continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _urlInputController,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(Icons.swap_horiz, color: Colors.grey),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 40,
                      ),
                      hintText: 'Input URL here',
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    keyboardType: TextInputType.url,
                  ),
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
                          side: const BorderSide(color: Colors.blue, width: 3),
                        ),
                      ),
                      onPressed: () {
                        _saveUrl();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProcessScreen()),
                        );
                      },
                      child: const Text(
                        'Start counting process',
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
