import 'package:flutter/material.dart';
import 'package:ticketbooking/custom/customappbar.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/youtubevideo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChatSupportPage extends StatefulWidget {
  const ChatSupportPage({super.key});

  @override
  _ChatSupportPageState createState() => _ChatSupportPageState();
}

class _ChatSupportPageState extends State<ChatSupportPage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'bot',
      'text':
          'Welcome to our chatbot! You can interact with me in two ways:\n - Click on the options below to get a response\n - Type the number of your desired option to get a response.'
    },
    {
      'sender': 'bot',
      'text':
          '1. How to search location \n2. How to book sites\n3.  where to check ticket\n4. How to see user profile\n5.How to use app',
      'isOptions': true
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  OverlayEntry? _overlayEntry;
  final List<String> _options = [
    'How to search location',
    'How to book sites ',
    'where to check ticket',
    'How to see user profile',
    'How to use app',
  ];
  final LayerLink _layerLink = LayerLink();

  void _sendMessage(String text) {
    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });
    _controller.clear();
    _respond(text);
    _scrollToBottom();
  }

  void _respond(String text) {
    String response = '';
    String videoUrl = '';

    if (text.toLowerCase().contains('how to search location') || text == '1') {
      response = 'Here is a video on how to search locatior:';
      videoUrl = 'https://www.youtube.com/watch?v=jGqoFR67Nbo';
    } else if (text.toLowerCase().contains('How to book sites') || text == '2') {
      response = 'Here is a video on How to book sites:';
      videoUrl = 'https://www.youtube.com/watch?v=jGqoFR67Nbo';
    } else if (text.toLowerCase().contains(' where to check ticket') ||
        text == '3') {
      response = 'Here is a video on where to check ticket:';
      videoUrl = 'https://www.youtube.com/watch?v=jGqoFR67Nbo';
    } else if (text.toLowerCase().contains('How to see user profile') ||
        text == '4') {
      response = 'Here is a video on how to How to see user profile:';
      videoUrl = 'https://www.youtube.com/watch?v=jGqoFR67Nbo';
    } else if (text.toLowerCase().contains('how to view list') || text == '5') {
      response = 'Here is a video on how to view the list:';
      videoUrl = 'https://www.youtube.com/watch?v=jGqoFR67Nbo';
    } else {
      response =
          'Sorry, I did not understand that. Please choose from the above options.';
      _addOptions();
    }

    setState(() {
      _messages.add({'sender': 'bot', 'text': response});
      if (videoUrl.isNotEmpty) {
        _messages.add({'sender': 'bot', 'videoUrl': videoUrl});
      }
    });
    _scrollToBottom();
  }

  void _addOptions() {
    setState(() {
      _messages.add({
        'sender': 'bot',
        'text':
            '1. How to search location\n2. How to book sites\n3.where to check ticket\n4. How to see user profile\n5.How to use app',
        'isOptions': true
      });
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _showOverlay(BuildContext context) {
    _hideOverlay(); // Ensure any existing overlay is removed

    final filteredOptions = _options
        .where((option) =>
            option.toLowerCase().contains(_controller.text.toLowerCase()))
        .toList();

    if (filteredOptions.isEmpty) {
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 62,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, -230),
          child: Material(
            elevation: 4.0,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: filteredOptions.map((option) {
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    _controller.text = option;
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: _controller.text.length),
                    );
                    _sendMessage(option);
                    _hideOverlay();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: customappbar(customappbartittle: "Chat Support"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(10.0),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessage(_messages[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _showOverlay(context);
                            } else {
                              _hideOverlay();
                            }
                          },
                          onEditingComplete: () {
                            if (_controller.text.isNotEmpty) {
                              _hideOverlay();
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: Color(0xFF2B2B81)),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            _sendMessage(_controller.text);
                            _hideOverlay();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    bool isUser = message['sender'] == 'user';
    bool isOptions = message['isOptions'] ?? false;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isUser ? Color(0xFF2B2B81) : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: isOptions
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOption('1) How to search location'),
                  _buildOption('2) How to book sites'),
                  _buildOption('3)  where to check ticket'),
                  _buildOption('4) How to see user profile'),
                  _buildOption('5)How to use app'),
                ],
              )
            : message['videoUrl'] != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message['text'] != null)
                        Text(
                          message['text'] ?? '',
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      SizedBox(height: 10),
                      YoutubePlayerWidget(url: message['videoUrl'] ?? ''),
                    ],
                  )
                : Text(
                    message['text'] ?? '',
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black,
                    ),
                  ),
      ),
    );
  }

  Widget _buildOption(String text) {
    return GestureDetector(
      onTap: () => _sendMessage(text),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF2B2B81),
          ),
        ),
      ),
    );
  }
}
