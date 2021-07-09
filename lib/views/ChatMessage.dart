import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String _name = "Lodovico Azzini";

class ChatMessage extends StatelessWidget {
  final String text;
  //// Used to specify the animation to run
  final AnimationController animationController;

  const ChatMessage({required this.text, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(_name[0]),
              ), // Name's first letter
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      text,
                    ),
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
