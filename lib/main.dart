import 'package:flutter/material.dart';
import 'message_provider.dart';
import 'package:provider/provider.dart';
import 'list_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Flutter App'),
      ),
      body: Center(
        child: messageProvider.isLoading
            ? CircularProgressIndicator() // แสดง Loading เมื่อ isLoading เป็น true
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    messageProvider.message,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await messageProvider.fetchMessage();
                    },
                    child: Text('Fetch Message from API'),
                  ),
                ],
              ),
      ),
    );
  }
}
