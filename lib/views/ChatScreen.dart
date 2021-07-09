import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  /// Controller for managing the content of the input text field
  final _textController = TextEditingController();

  /// The list of sent messages
  final List<ChatMessage> _messages = [];

  /// Used to request the focus on a particular node
  var _focusNode = FocusNode();

  /// Whether there is text in the field or not
  var _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendly Chat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              )
            : null,
        child: Column(
          children: [
            // The list of messages will fill the ListView
            Flexible(
              child: ListView.builder(
                itemBuilder: (_, int index) => _messages[index],
                padding: EdgeInsets.all(8.0),
                itemCount: _messages.length,
                reverse: true,
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the widget with the input field and the send button
  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      // A row allows to put a button on the side of the text field
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Flexible will fill the remaining space from the button
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 12),
              child: TextField(
                controller: _textController,
                // Send only if is composing
                onSubmitted: _isComposing ? _handleSubmitted : null,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
                maxLines: null,
                // Change the composing status based on the text value
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? CupertinoButton(
                    child: Text('Send'),
                    onPressed: _isComposing
                        ? () => _handleSubmitted(_textController.text)
                        : null,
                  )
                : IconButton(
                    alignment: Alignment.bottomRight,
                    icon: IconTheme(
                      child: const Icon(Icons.send),
                      data: IconThemeData(
                        color: _isComposing
                            ? Theme.of(context).accentColor
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                    onPressed: _isComposing
                        ? () => _handleSubmitted(_textController.text)
                        : null,
                  ),
          )
        ],
      ),
    );
  }

  /// Handle the submission of a message
  ///
  /// Clear the text field
  /// Add the message to the [_messages] list
  /// Put the focus on the text field
  void _handleSubmitted(String value) {
    _textController.clear();
    var message = ChatMessage(
      text: value,
      animationController: AnimationController(
        vsync: this, // the ticket provider
        duration: const Duration(milliseconds: 180),
      ),
    );
    setState(() {
      _isComposing = false;
      _messages.insert(0, message); // + reverse auto add to bottom
    });
    _focusNode.requestFocus();
    message.animationController.forward(); // start running the animation
  }
}
