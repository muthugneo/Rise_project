import 'package:flutter/material.dart';

class AboutGFA extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AboutGFA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("About GFA"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: SizedBox(
                height: 75,
                child: Image.asset('assets/gfa.png'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 16),
                  child: Text(
                    "Who We Are",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
              child: Wrap(
                children: const [
                  Text(
                    "Good Food Alliance - GFA is a Private Limited Company established by The Rise Mutual Benefit Trust with the vision of becoming a respectable player in the global organic and good food supply chain, with stakes in production, aggregation, value addition, appropriate technologies, storage, marketing and sales.",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 16),
                  child: Text(
                    "Philosophy",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 16, right: 16),
              child: Text(
                "The Rise holds sage Thirumoolar as one of the most eminent Tamil philosophers who taught the world that Food is the first and most basic medicine. Covid -19 has underscored the importance of immune building good food. Good Food Alliance takes inspiration from this Philosophical Foundation.",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
