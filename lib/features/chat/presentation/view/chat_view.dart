// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';
// import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';

// class ChatScreen extends StatefulWidget {
//   final String senderId;
//   final String receiverId;

//   const ChatScreen({
//     super.key,
//     required this.senderId,
//     required this.receiverId,
//   });

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatBloc>().add(LoadMessagesEvent(
//           senderId: widget.senderId,
//           receiverId: widget.receiverId,
//         ));
//   }

//   /// ✅ **Scroll to Bottom Smoothly**
//   void _scrollToBottom() {
//     Future.delayed(const Duration(milliseconds: 300), () {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Koselie Chat"),
//         backgroundColor: Colors.purple,
//       ),
//       body: BlocListener<ChatBloc, ChatState>(
//         listener: (context, state) {
//           if (state.error != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error!),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }

//           _scrollToBottom();
//         },
//         child: Column(
//           children: [
//             Expanded(
//               child: BlocBuilder<ChatBloc, ChatState>(
//                 builder: (context, state) {
//                   final messages = state.messages;

//                   if (state.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (messages.isEmpty) {
//                     return const Center(child: Text("No messages yet"));
//                   }

//                   return ListView.builder(
//                     controller: _scrollController,
//                     padding: const EdgeInsets.all(10),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       final isSentByMe = message.senderId == widget.senderId;

//                       return Align(
//                         alignment: isSentByMe
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 10),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color:
//                                 isSentByMe ? Colors.purple : Colors.grey[800],
//                             borderRadius: BorderRadius.only(
//                               topLeft: const Radius.circular(10),
//                               topRight: const Radius.circular(10),
//                               bottomLeft: isSentByMe
//                                   ? const Radius.circular(10)
//                                   : Radius.zero,
//                               bottomRight: isSentByMe
//                                   ? Radius.zero
//                                   : const Radius.circular(10),
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 message.message,
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 _formatTime(message.createdAt),
//                                 style: const TextStyle(
//                                     color: Colors.white70, fontSize: 10),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             _buildMessageInput(context),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ✅ **Send Message Input Field**
//   Widget _buildMessageInput(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 filled: true,
//                 fillColor: Colors.white10,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Colors.purple),
//             onPressed: () {
//               if (_controller.text.isNotEmpty) {
//                 final chatBloc = context.read<ChatBloc>();

//                 final newMessage = MessageEntity(
//                   senderId: widget.senderId,
//                   receiverId: widget.receiverId,
//                   message: _controller.text,
//                   createdAt: DateTime.now(),
//                 );

//                 chatBloc.add(SendMessage(
//                   senderId: widget.senderId,
//                   receiverId: widget.receiverId,
//                   message: newMessage.message,
//                 ));

//                 _controller.clear();
//                 _scrollToBottom();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   /// ✅ **Format Timestamp for Messages**
//   String _formatTime(DateTime time) {
//     return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String senderId;
  final String receiverId;

  const ChatScreen({
    super.key,
    required this.senderId,
    required this.receiverId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessagesEvent(
          senderId: widget.senderId,
          receiverId: widget.receiverId,
        ));
  }

  /// ✅ **Scroll to Bottom Smoothly**
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Koselie Chat"),
        backgroundColor: Colors.purple,
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }

          _scrollToBottom();
        },
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  final messages = state.messages;

                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (messages.isEmpty) {
                    return const Center(child: Text("No messages yet"));
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSentByMe = message.senderId == widget.senderId;

                      return GestureDetector(
                        onLongPress: () => _showDeleteDialog(context, message),
                        child: Align(
                          alignment: isSentByMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  isSentByMe ? Colors.purple : Colors.grey[800],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10),
                                topRight: const Radius.circular(10),
                                bottomLeft: isSentByMe
                                    ? const Radius.circular(10)
                                    : Radius.zero,
                                bottomRight: isSentByMe
                                    ? Radius.zero
                                    : const Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.message,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatTime(message.createdAt),
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  /// ✅ **Send Message Input Field**
  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.purple),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final chatBloc = context.read<ChatBloc>();

                final newMessage = MessageEntity(
                  senderId: widget.senderId,
                  receiverId: widget.receiverId,
                  message: _controller.text,
                  createdAt: DateTime.now(),
                );

                chatBloc.add(SendMessage(
                  senderId: widget.senderId,
                  receiverId: widget.receiverId,
                  message: newMessage.message,
                ));

                _controller.clear();
                _scrollToBottom();
              }
            },
          ),
        ],
      ),
    );
  }

  /// ✅ **Delete Message Confirmation Dialog**
  void _showDeleteDialog(BuildContext context, MessageEntity message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Message"),
          content: const Text("Are you sure you want to delete this message?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteMessage(message);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  /// ✅ **Delete Message Event Dispatch**
  void _deleteMessage(MessageEntity message) {
    context.read<ChatBloc>().add(DeleteMessageEvent(
          messageId: message.messageId ?? '',
          senderId: widget.senderId,
          receiverId: widget.receiverId,
          token: '',
        ));
  }

  /// ✅ **Format Timestamp for Messages**
  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
