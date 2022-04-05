import 'package:flutter/material.dart';
import 'package:student_profile/common/app_colors.dart';
import 'package:student_profile/common/app_page_layout.dart';
import 'package:student_profile/common/text_styles.dart';
import 'package:student_profile/models/Student.dart';
import 'package:student_profile/models/messages.dart';
import 'package:student_profile/services/message_service.dart';

class ViewMessagesScreen extends StatefulWidget {

  final String studentId;

  static const String routeName = "toTeacherViewMessageScreen";

  const ViewMessagesScreen({Key? key, required this.studentId}) : super(key: key);

  @override
  _ViewMessagesScreenState createState() => _ViewMessagesScreenState();
}

class _ViewMessagesScreenState extends State<ViewMessagesScreen> {

  late final Stream<List<Message>> _messageStream;
  final TextEditingController _editingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageStream = MessageService().getMessages(widget.studentId);
  }


  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      onBackPress: () {
        Navigator.pop(context);
      },
      title: "Messages",
      body: ListView(
        children: [
          _buildAddMessageContainer(),
          _buildMessageList(),
        ],
      ),
    );
  }

  Future _sendMessage() async {

    if(_formKey.currentState!.validate()) {
      Message message = Message(message: _editingController.text);
      MessageService().addMessage(message: message, studentId: widget.studentId);
    }

  }

  Future _deleteMessage({required String id}) async {
    MessageService().deleteMessage(id: id, studentId: widget.studentId);
  }

  Widget _buildMessageList() => StreamBuilder<List<Message>>(
      stream: _messageStream,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if(snapshot.connectionState==ConnectionState.waiting) {
          return const Text("Loading...");
        }
        if(snapshot.data!.isNotEmpty) {
          return Column(
            children: [
              for(Message message in snapshot.data!) _buildMessageListItem(message: message.message, onPressDelete: () {
                _deleteMessage(id: message.docId??"");
              })
            ],
          );
        }else{
          return const Text("Empty list");
        }
      },
  );

  Widget _buildMessageListItem({required String message, required VoidCallback onPressDelete}) => Container(
    padding: const EdgeInsets.all(10),
    height: 50,
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(color: AppColors.greyF5, blurRadius: 7, spreadRadius: 5)
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(message, style: TextStyles.greyTextStyle12pt,),
        IconButton(onPressed: onPressDelete, icon: const Icon(Icons.delete, size: 15, color: AppColors.redB24,))
      ],
    ),
  );

  Widget _buildAddMessageContainer() => Container(
    padding: const EdgeInsets.all(10),
    height: 160,
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(color: AppColors.greyF5, blurRadius: 7, spreadRadius: 5)
      ],
    ),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _editingController,
            decoration: InputDecoration(
              label: Text("Message"),
              hintText: "Enter Message",
              prefixIcon: Icon(Icons.message),
            ),
            validator: (val) => val!.isEmpty ? "Please enter message" : null,
          ),
          ElevatedButton(onPressed: _sendMessage, child: const Text("Send"))
        ],
      ),
    ),
  );

}
