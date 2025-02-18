//original
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

//                       return GestureDetector(
//                         onLongPress: () => _showDeleteDialog(context, message),
//                         child: Align(
//                           alignment: isSentByMe
//                               ? Alignment.centerRight
//                               : Alignment.centerLeft,
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 10),
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color:
//                                   isSentByMe ? Colors.purple : Colors.grey[800],
//                               borderRadius: BorderRadius.only(
//                                 topLeft: const Radius.circular(10),
//                                 topRight: const Radius.circular(10),
//                                 bottomLeft: isSentByMe
//                                     ? const Radius.circular(10)
//                                     : Radius.zero,
//                                 bottomRight: isSentByMe
//                                     ? Radius.zero
//                                     : const Radius.circular(10),
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   message.message,
//                                   style: const TextStyle(color: Colors.white),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   _formatTime(message.createdAt),
//                                   style: const TextStyle(
//                                       color: Colors.white70, fontSize: 10),
//                                 ),
//                               ],
//                             ),
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

//   /// ✅ **Delete Message Confirmation Dialog**
//   void _showDeleteDialog(BuildContext context, MessageEntity message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Delete Message"),
//           content: const Text("Are you sure you want to delete this message?"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
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

//   /// ✅ **Delete Message Event Dispatch**
//   void _deleteMessage(MessageEntity message) {
//     context.read<ChatBloc>().add(DeleteMessageEvent(
//           messageId: message.messageId ?? '',
//           senderId: widget.senderId,
//           receiverId: widget.receiverId,
//           token: '',
//         ));
//   }

//   /// ✅ **Format Timestamp for Messages**
//   String _formatTime(DateTime time) {
//     return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
//   }
// }

// chatgpt

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';
// import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';

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
//         title: _buildReceiverProfile(),
//         centerTitle: true, // Ensure the title is centered
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

//                       return Row(
//                         mainAxisAlignment: isSentByMe
//                             ? MainAxisAlignment.end
//                             : MainAxisAlignment.start,
//                         crossAxisAlignment:
//                             CrossAxisAlignment.start, // Align items to the top
//                         children: [
//                           if (!isSentByMe)
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child:
//                                   _buildReceiverAvatar(), // Display avatar for received messages
//                             ),
//                           Expanded(
//                             child: GestureDetector(
//                               onLongPress: () =>
//                                   _showDeleteDialog(context, message),
//                               child: Align(
//                                 alignment: isSentByMe
//                                     ? Alignment.centerRight
//                                     : Alignment.centerLeft,
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(
//                                       vertical: 5, horizontal: 10),
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: isSentByMe
//                                         ? Colors.purple
//                                         : Colors.grey[800],
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: const Radius.circular(10),
//                                       topRight: const Radius.circular(10),
//                                       bottomLeft: isSentByMe
//                                           ? const Radius.circular(10)
//                                           : Radius.zero,
//                                       bottomRight: isSentByMe
//                                           ? Radius.zero
//                                           : const Radius.circular(10),
//                                     ),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         message.message,
//                                         style: const TextStyle(
//                                             color: Colors.white),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         _formatTime(message.createdAt),
//                                         style: const TextStyle(
//                                             color: Colors.white70,
//                                             fontSize: 10),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (isSentByMe) const SizedBox(width: 40)
//                         ],
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

//   /// **Builds the receiver profile widget to display in the app bar.**
//   Widget _buildReceiverProfile() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           radius: 20,
//           backgroundImage: (widget.receiverImage.isNotEmpty)
//               ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
//               : const AssetImage("assets/images/default_avatar.png")
//                   as ImageProvider,
//         ),
//         const SizedBox(height: 4),
//         Text(
//           widget.receiverUsername,
//           style: const TextStyle(
//               fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   /// **Builds the receiver avatar for displaying next to received messages.**
//   Widget _buildReceiverAvatar() {
//     return CircleAvatar(
//       radius: 16,
//       backgroundImage: (widget.receiverImage.isNotEmpty)
//           ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
//           : const AssetImage("assets/images/default_avatar.png")
//               as ImageProvider,
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

//   /// ✅ **Delete Message Confirmation Dialog**
//   void _showDeleteDialog(BuildContext context, MessageEntity message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Delete Message"),
//           content: const Text("Are you sure you want to delete this message?"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
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

//   /// ✅ **Delete Message Event Dispatch**
//   void _deleteMessage(MessageEntity message) {
//     context.read<ChatBloc>().add(DeleteMessageEvent(
//           messageId: message.messageId ?? '',
//           senderId: widget.senderId,
//           receiverId: widget.receiverId,
//           token: '',
//         ));
//   }

//   /// ✅ **Format Timestamp for Messages**
//   String _formatTime(DateTime time) {
//     return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
//   }
// }

// Deepseek
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/chat/domain/entity/message_entity.dart';
// import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';

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
//     return Scaffold(
//       appBar: AppBar(
//         title: _buildReceiverProfile(),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.purple.shade700, Colors.purple.shade400],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
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
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.purple,
//                       ),
//                     );
//                   }

//                   if (messages.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         "No messages yet",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     );
//                   }

//                   return ListView.builder(
//                     controller: _scrollController,
//                     padding: const EdgeInsets.all(10),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       final isSentByMe = message.senderId == widget.senderId;

//                       return Row(
//                         mainAxisAlignment: isSentByMe
//                             ? MainAxisAlignment.end
//                             : MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (!isSentByMe)
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: _buildReceiverAvatar(),
//                             ),
//                           Expanded(
//                             child: GestureDetector(
//                               onLongPress: () =>
//                                   _showDeleteDialog(context, message),
//                               child: AnimatedContainer(
//                                 duration: const Duration(milliseconds: 200),
//                                 margin: const EdgeInsets.symmetric(
//                                     vertical: 5, horizontal: 10),
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   color: isSentByMe
//                                       ? Colors.purple.shade600
//                                       : Colors.grey.shade800,
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: const Radius.circular(15),
//                                     topRight: const Radius.circular(15),
//                                     bottomLeft: isSentByMe
//                                         ? const Radius.circular(15)
//                                         : Radius.zero,
//                                     bottomRight: isSentByMe
//                                         ? Radius.zero
//                                         : const Radius.circular(15),
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.2),
//                                       blurRadius: 5,
//                                       offset: const Offset(0, 3),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       message.message,
//                                       style:
//                                           const TextStyle(color: Colors.white),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       _formatTime(message.createdAt),
//                                       style: const TextStyle(
//                                           color: Colors.white70, fontSize: 10),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (isSentByMe) const SizedBox(width: 40)
//                         ],
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

//   Widget _buildReceiverProfile() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           radius: 20,
//           backgroundImage: (widget.receiverImage.isNotEmpty)
//               ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
//               : const AssetImage("assets/images/default_avatar.png")
//                   as ImageProvider,
//         ),
//         const SizedBox(width: 10),
//         Text(
//           widget.receiverUsername,
//           style: const TextStyle(
//               fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   Widget _buildReceiverAvatar() {
//     return CircleAvatar(
//       radius: 16,
//       backgroundImage: (widget.receiverImage.isNotEmpty)
//           ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
//           : const AssetImage("assets/images/default_avatar.png")
//               as ImageProvider,
//     );
//   }

//   Widget _buildMessageInput(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade900,
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _controller,
//                 decoration: InputDecoration(
//                   hintText: 'Type a message...',
//                   hintStyle: TextStyle(color: Colors.grey.shade500),
//                   filled: true,
//                   fillColor: Colors.transparent,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [Colors.purple.shade600, Colors.purple.shade400],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.purple.withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
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
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
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
//           token: '',
//         ));
//   }

//   String _formatTime(DateTime time) {
//     return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
//   }
// }

// chat
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/chat/domain/entity/message_entity.dart';
import 'package:koselie/features/chat/presentation/view_model/bloc/chat_bloc.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            // CircleAvatar(
            //   backgroundImage: (widget.receiverImage.isNotEmpty)
            //       ? NetworkImage(
            //           "${ApiEndpoints.imageUrl}/${widget.receiverImage}")
            //       : const AssetImage("assets/images/default_avatar.png")
            //           as ImageProvider,
            // ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(80),
              child: Text(
                widget.receiverUsername,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
        elevation: 1,
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error!), backgroundColor: Colors.red),
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
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  }

                  if (messages.isEmpty) {
                    return const Center(
                      child: Text("No messages yet",
                          style: TextStyle(color: Colors.grey)),
                    );
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
                        child: Column(
                          crossAxisAlignment: isSentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: isSentByMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!isSentByMe) _buildReceiverAvatar(),
                                Flexible(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 14),
                                    decoration: BoxDecoration(
                                      color: isSentByMe
                                          ? Colors.blue
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      message.message,
                                      style: TextStyle(
                                        color: isSentByMe
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Text(
                                _formatTime(message.createdAt),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ),
                          ],
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

  Widget _buildReceiverAvatar() {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, bottom: 10),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: (widget.receiverImage.isNotEmpty)
            ? NetworkImage("${ApiEndpoints.imageUrl}/${widget.receiverImage}")
            : const AssetImage("assets/images/default_avatar.png")
                as ImageProvider,
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      hintText: 'Type a message...', border: InputBorder.none),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
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

  void _deleteMessage(MessageEntity message) {
    context.read<ChatBloc>().add(DeleteMessageEvent(
          messageId: message.messageId ?? '',
          senderId: widget.senderId,
          receiverId: widget.receiverId,
          token: '', // Ensure the correct token if needed
        ));
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
