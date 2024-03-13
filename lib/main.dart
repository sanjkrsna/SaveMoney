import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permission Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: PermissionDemo(),
    );
  }
}

class PermissionDemo extends StatefulWidget {
  @override
  _PermissionDemoState createState() => _PermissionDemoState();
}

class _PermissionDemoState extends State<PermissionDemo> {
  List<SmsMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _retrieveMessages();
  }

  Future<void> _retrieveMessages() async {
    final query = SmsQuery();
    final messages = await query.getAllSms;
    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Messages'),
      ),
      body: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          SmsMessage message = _messages[index];
          return ListTile(
            title: Text('${message.sender} [${message.date}]'),
            subtitle: Text('${message.body}'),
          );
        },
      ),
    );
  }
}
