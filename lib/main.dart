import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(WhatsAppRedirectApp());
}

class WhatsAppRedirectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Redirect',
      home: WhatsAppHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WhatsAppHome extends StatefulWidget {
  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome> {
  final TextEditingController _controller = TextEditingController();

  void _openWhatsApp() async {
    String number = _controller.text.trim();
    if (number.isEmpty || number.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid mobile number")),
      );
      return;
    }

    String fullNumber = '91$number'; // add default country code
    String url = 'https://wa.me/$fullNumber';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch WhatsApp")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WhatsApp Quick Message')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                prefixText: '+91 ',
                border: OutlineInputBorder(),
              ),
              maxLength: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openWhatsApp,
              child: Text('Open in WhatsApp'),
            ),
          ],
        ),
      ),
    );
  }
}