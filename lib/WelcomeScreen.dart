import 'package:flutter/material.dart';
import 'package:report/home_page.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child:  CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  child: Icon(
                    Icons.description_outlined,
                    size: 64,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Welcome to\nReportGen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Effortlessly create and customize professional reports in minutes. Let\'s get started.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              // Increased space to push the button down

            ],
          ),
        ),
      ),

      bottomNavigationBar:  Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {

             Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Get Started',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}