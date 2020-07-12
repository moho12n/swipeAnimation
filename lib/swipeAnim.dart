import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Offset _offset = Offset.zero; // changed
double gauche = 0;
double droite = 0;
String accept = " ";

class Swipe extends StatefulWidget {
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Container(
              height: 96,
              width: MediaQuery.of(context).size.width - 80,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey,
                      ),
                      height: 48,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.call_received,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Transform.translate(
                      offset: Offset(gauche, droite),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          if (details.delta.dx > 0) {
                            if (gauche + details.delta.distance < 118)
                              setState(() => gauche += details.delta.distance);
                            if (gauche > 100)
                              setState(() {
                                accept = "Accepted";
                              });
                          }
                          if (details.delta.dx < 0) {
                            if (gauche - details.delta.distance > -118)
                              setState(() => gauche -= details.delta.distance);
                            if (gauche < -100)
                              setState(() {
                                accept = "Declined";
                              });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          height: 76,
                          width: 76,
                          child: Icon(
                            Icons.person_pin_circle,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 88.0),
              child: Column(
                children: <Widget>[
                  Text("State is :\n"),
                  Text(
                    accept,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:
                            accept == "Declined" ? Colors.red : Colors.green),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
