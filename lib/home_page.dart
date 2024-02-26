import 'package:flutter/material.dart';
import 'package:loading_test_animation/widgets/custom_button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = !isLoading;
                });
              },
              child: isLoading ? const Text('Stop') : const Text('Loading'),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButtonWidget(
              isLoading: isLoading,
            )
          ],
        ),
      ),
    );
  }
}
