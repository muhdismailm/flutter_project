import 'package:flutter/material.dart';
import 'package:login_1/src/features/authentication/screens/login/login_form.dart';
// Correct import statement

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "WORKIFY",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.work_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset('assets/images/plumber.png'), // Add your logo here
            ), // Add your logo here
            const SizedBox(height: 20),
            const Text(
              'Welcome to workify!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Connecting the workers.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return const LoginForm();
                  })
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.blue, // Background color
                   foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to signup screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Background color
                   foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Sign Up'),
              ),
          ],
        ),
      ),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "workify",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.work_rounded),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),

      ),
    );
  }
}


