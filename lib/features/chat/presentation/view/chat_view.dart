// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';
// import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

// class ChatScreen extends StatefulWidget {
//   final String senderId;
//   final String receiverId;
//   final String receiverUsername;
//   final String receiverImage;

//   const ChatScreen({
//     super.key,
//     required this.senderId,
//     required this.receiverId,
//     required this.receiverUsername,
//     required this.receiverImage,
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
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         final isDarkMode = themeState is DarkThemeState;

//         // Define colors based on theme
//         final backgroundColor = isDarkMode ? Colors.black : Colors.white;
//         final textColor = isDarkMode ? Colors.white : Colors.black;
//         final appBarGradient = isDarkMode
//             ? [Colors.black87, Colors.black54]
//             : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];
//         final messageBubbleColorSent =
//             isDarkMode ? Colors.purple[700]! : Colors.purple;
//         final messageBubbleColorReceived =
//             isDarkMode ? Colors.grey[800]! : Colors.grey.shade200;
//         final inputBackgroundColor =
//             isDarkMode ? Colors.grey[850]! : Colors.grey.shade100;
//         final iconColor = isDarkMode ? Colors.white : Colors.black;

//         return Scaffold(
//           backgroundColor: backgroundColor,
//           appBar: AppBar(
//             title: Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: widget.receiverImage.isNotEmpty
//                       ? NetworkImage(
//                           "${ApiEndpoints.imageUrl}/${widget.receiverImage}")
//                       : const AssetImage("assets/images/default_avatar.png")
//                           as ImageProvider,
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     widget.receiverUsername,
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             centerTitle: true,
//             elevation: 5,
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: appBarGradient,
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           body: BlocListener<ChatBloc, ChatState>(
//             listener: (context, state) {
//               if (state.error != null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.error!),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//               _scrollToBottom();
//             },
//             child: Container(
//               color: backgroundColor,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: BlocBuilder<ChatBloc, ChatState>(
//                       builder: (context, state) {
//                         final messages = state.messages;

//                         if (state.isLoading) {
//                           return Center(
//                             child: CircularProgressIndicator(
//                                 color: Theme.of(context).primaryColor),
//                           );
//                         }

//                         if (messages.isEmpty) {
//                           return Center(
//                             child: Text(
//                               "No messages yet",
//                               style: GoogleFonts.poppins(color: Colors.grey),
//                             ),
//                           );
//                         }

//                         return ListView.builder(
//                           controller: _scrollController,
//                           padding: const EdgeInsets.all(10),
//                           itemCount: messages.length,
//                           itemBuilder: (context, index) {
//                             final message = messages[index];
//                             final isSentByMe =
//                                 message.senderId == widget.senderId;

//                             return GestureDetector(
//                               onLongPress: () =>
//                                   _showDeleteDialog(context, message),
//                               child: Column(
//                                 crossAxisAlignment: isSentByMe
//                                     ? CrossAxisAlignment.end
//                                     : CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     mainAxisAlignment: isSentByMe
//                                         ? MainAxisAlignment.end
//                                         : MainAxisAlignment.start,
//                                     children: [
//                                       if (!isSentByMe) _buildReceiverAvatar(),
//                                       Flexible(
//                                         child: Container(
//                                           constraints: BoxConstraints(
//                                             maxWidth: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.7,
//                                           ),
//                                           margin: const EdgeInsets.symmetric(
//                                               vertical: 4, horizontal: 8),
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 10, horizontal: 14),
//                                           decoration: BoxDecoration(
//                                             color: isSentByMe
//                                                 ? messageBubbleColorSent
//                                                 : messageBubbleColorReceived,
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black
//                                                     .withOpacity(0.1),
//                                                 blurRadius: 4,
//                                                 offset: const Offset(2, 2),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Text(
//                                             message.message,
//                                             style: GoogleFonts.poppins(
//                                               color: isSentByMe
//                                                   ? Colors.white
//                                                   : textColor,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 4),
//                                     child: Text(
//                                       _formatTime(message.createdAt),
//                                       style: GoogleFonts.poppins(
//                                           color: Colors.grey, fontSize: 12),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   _buildMessageInput(
//                       context, inputBackgroundColor, iconColor, textColor),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildReceiverAvatar() {
//     return Padding(
//       padding: const EdgeInsets.only(right: 4.0, bottom: 10),
//       child: CircleAvatar(
//         radius: 16,
//         backgroundImage: (widget.receiverImage.isNotEmpty)
//             ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
//             : const AssetImage("assets/images/default_avatar.png")
//                 as ImageProvider,
//       ),
//     );
//   }

//   Widget _buildMessageInput(BuildContext context, Color inputBackgroundColor,
//       Color iconColor, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       color: inputBackgroundColor,
//       child: Row(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: TextField(
//                 controller: _controller,
//                 style: TextStyle(color: textColor),
//                 decoration: const InputDecoration(
//                   hintText: 'Type a message...',
//                   hintStyle: TextStyle(color: Colors.grey), //TODO: check it
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Container(
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle, color: Colors.black),
//             child: IconButton(
//               icon: const Icon(Icons.send, color: Colors.white),
//               onPressed: () {
//                 if (_controller.text.isNotEmpty) {
//                   final chatBloc = context.read<ChatBloc>();
//                   final newMessage = MessageEntity(
//                     senderId: widget.senderId,
//                     receiverId: widget.receiverId,
//                     message: _controller.text,
//                     createdAt: DateTime.now(),
//                   );

//                   chatBloc.add(SendMessage(
//                     senderId: widget.senderId,
//                     receiverId: widget.receiverId,
//                     message: newMessage.message,
//                   ));

//                   _controller.clear();
//                   _scrollToBottom();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showDeleteDialog(BuildContext context, MessageEntity message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Delete Message"),
//           content: const Text("Are you sure you want to delete this message?"),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancel")),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _deleteMessage(message);
//               },
//               child: const Text("Delete", style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteMessage(MessageEntity message) {
//     context.read<ChatBloc>().add(DeleteMessageEvent(
//           messageId: message.messageId ?? '',
//           senderId: widget.senderId,
//           receiverId: widget.receiverId,
//           token: '', // Ensure the correct token if needed
//         ));
//   }

//   String _formatTime(DateTime time) {
//     return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

class ChatScreen extends StatefulWidget {
  final String senderId;
  final String receiverId;
  final String receiverUsername;
  final String receiverImage;

  const ChatScreen({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.receiverUsername,
    required this.receiverImage,
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

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        // Define colors based on theme
        final backgroundColor =
            isDarkMode ? Colors.grey[900]! : Colors.grey[100]!;
        final textColor = isDarkMode ? Colors.white : Colors.black87;
        final appBarGradient = isDarkMode
            ? [Colors.grey[850]!, Colors.grey[900]!]
            : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];
        final messageBubbleColorSent =
            isDarkMode ? Colors.purple[800]! : Colors.purple[500]!;
        final messageBubbleColorReceived =
            isDarkMode ? Colors.grey[800]! : Colors.white;
        final inputBackgroundColor =
            isDarkMode ? Colors.grey[850]! : Colors.white;
        final iconColor = isDarkMode ? Colors.white70 : Colors.grey[700]!;
        final hintTextColor =
            isDarkMode ? Colors.grey[600]! : Colors.grey[400]!;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Row(
              children: [
                Hero(
                  tag: 'receiver_avatar_${widget.receiverId}',
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: widget.receiverImage.isNotEmpty
                        ? NetworkImage(
                            "${ApiEndpoints.imageUrl}/${widget.receiverImage}")
                        : const AssetImage("assets/images/default_avatar.png")
                            as ImageProvider,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.receiverUsername,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: false,
            elevation: 3,
            shadowColor: Colors.black.withOpacity(0.3),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: appBarGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  // Add your menu options here
                },
              ),
            ],
          ),
          body: BlocListener<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!,
                        style: const TextStyle(color: Colors.white)),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              _scrollToBottom();
            },
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context)
                    .unfocus(); // Dismiss keyboard on tap outside
              },
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<ChatBloc, ChatState>(
                      builder: (context, state) {
                        final messages = state.messages;

                        if (state.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor),
                          );
                        }

                        if (messages.isEmpty) {
                          return Center(
                            child: Text(
                              "No messages yet. Start the conversation!",
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isSentByMe =
                                message.senderId == widget.senderId;

                            return _buildChatMessage(
                                message,
                                isSentByMe,
                                messageBubbleColorSent,
                                messageBubbleColorReceived,
                                textColor);
                          },
                        );
                      },
                    ),
                  ),
                  _buildMessageInput(context, inputBackgroundColor, iconColor,
                      textColor, hintTextColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatMessage(
      MessageEntity message,
      bool isSentByMe,
      Color messageBubbleColorSent,
      Color messageBubbleColorReceived,
      Color textColor) {
    return GestureDetector(
      onLongPress: () => _showDeleteDialog(context, message),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment:
              isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!isSentByMe) _buildReceiverAvatar(),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: isSentByMe
                          ? messageBubbleColorSent
                          : messageBubbleColorReceived,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.message,
                      style: GoogleFonts.poppins(
                        color: isSentByMe ? Colors.white : textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12, right: 12),
              child: Text(
                _formatTime(message.createdAt),
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiverAvatar() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 10),
      child: Hero(
        tag: 'receiver_avatar_${widget.receiverId}',
        child: CircleAvatar(
          radius: 18,
          backgroundImage: widget.receiverImage.isNotEmpty
              ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
              : const AssetImage("assets/images/default_avatar.png")
                  as ImageProvider,
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context, Color inputBackgroundColor,
      Color iconColor, Color textColor, Color hintTextColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: inputBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  // color: Colors.transparent,
                  // borderRadius: BorderRadius.circular(25),
                  // border: Border.all(color: Colors.grey[400]!, width: 0.8),
                  ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _controller,
                  style: TextStyle(color: textColor, fontSize: 16),

                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: hintTextColor),
                  ),
                  textCapitalization:
                      TextCapitalization.sentences, // Auto capitalize sentences
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 2,
              shadowColor: Colors.purple.withOpacity(0.4),
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, MessageEntity message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Message",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          content: Text("Are you sure you want to delete this message?",
              style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel",
                  style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteMessage(message);
              },
              child: Text("Delete",
                  style: GoogleFonts.poppins(
                      color: Colors.red, fontWeight: FontWeight.w500)),
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        );
      },
    );
  }

  void _deleteMessage(MessageEntity message) {
    context.read<ChatBloc>().add(DeleteMessageEvent(
          messageId: message.messageId ?? '',
          senderId: widget.senderId,
          receiverId: widget.receiverId,
          token: '', // Ensure the correct token if needed
        ));
  }

  String _formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time); // Format as "h:mm AM/PM"
  }
}
