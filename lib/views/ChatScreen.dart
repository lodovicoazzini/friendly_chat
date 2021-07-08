import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  /// Controller for managing the content of the input text field
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Friendly Chat')),
      body: _buildTextComposer(),
    );
  }

  /// Build the widget with the input field and the send button
  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      // A row allows to put a button on the side of the text field
      child: Row(
        children: [
          // Flexible will fill the remaining space from the button
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: IconTheme(
                child: const Icon(Icons.send),
                data: IconThemeData(color: Theme.of(context).accentColor),
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          )
        ],
      ),
    );
  }

  /// Handle the submission of a message
  ///
  /// Clear the text field
  void _handleSubmitted(String value) {
    _textController.clear();
  }
}
