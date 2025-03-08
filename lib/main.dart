import 'package:flutter/material.dart';
import 'package:login_1/src/utils/theme/theme.dart';
void main() => runApp(const App());
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: TAppTheme.lightTheme,  
      darkTheme:TAppTheme.dartTheme,
      themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home:AppHome(),
    );
  }
}


class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("workify"),

        leading: const Icon(Icons.work_rounded),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.workspace_premium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text("heading",style:Theme.of(context).textTheme.headlineMedium),
            Text("sub-paragraph",style:Theme.of(context).textTheme.headlineSmall),
            Text("Paragraph",style:Theme.of(context).textTheme.bodyMedium),
            ElevatedButton(
              onPressed: () {},
              child: Text("button"),
            ),
           
          ],
        ),
      ),
    );
  }
}