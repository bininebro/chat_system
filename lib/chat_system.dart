import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userId = "C823AD12";
  final textController = TextEditingController();
  List<UserMessage>? messages = [];
  OpenChannel? channel;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() => isLoading = true);
    initData();
  }

  sendMessage() async {
    if (textController.text.isNotEmpty) {
      var text = textController.text;
      textController.clear();

      var mes = UserMessageParams(message: text);

      var message = channel?.sendUserMessage(mes);
      if (message != null) {
        setState(() {
          messages?.insert(0, message);
        });
      }
    }
  }

  initData() async {
    try {
      final sendbird =
          SendbirdSdk(appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF');
      await sendbird.connect(userId, nickname: 'BiniyamN');
      channel = await OpenChannel.getChannel(
          "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211");
      channel?.enter();

      sendbird.addChannelEventHandler('CALLBACK_ID', EventListen(onMessage));
      setState(() => isLoading = false);
    } catch (e) {
      print('$e');
    }
  }

  onMessage(UserMessage? message) {
    if (message != null) {
      setState(() {
        messages?.insert(0, message);
      });
    }
  }

  String formatKoreanTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    return DateTime.now().difference(dateTime).inSeconds < 60
        ? "지금"
        : DateTime.now().difference(dateTime).inSeconds >= 60 &&
                DateTime.now().difference(dateTime).inMinutes < 60
            ? '${DateTime.now().difference(dateTime).inMinutes}분 전'
            : DateTime.now().difference(dateTime).inHours >= 1 &&
                    DateTime.now().difference(dateTime).inHours < 24
                ? '${DateTime.now().difference(dateTime).inHours}시간 전'
                : DateTime.now().difference(dateTime).inHours >= 24
                    ? '${DateTime.now().difference(dateTime).inDays}일 전'
                    : '';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    void onTextChanged() {
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          '강남스팟',
          style: TextStyle(fontSize: 16),
        )),
        leading: Image.asset('assets/btcon_back.png'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset('assets/menu.png'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const CupertinoActivityIndicator()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    reverse: true,
                    itemCount: messages?.length,
                    itemBuilder: (context, index) {
                      if (messages![index].sender?.userId != userId) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff1A1A1A),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messages![index].sender?.nickname ?? "",
                                        style: const TextStyle(
                                            color: Color(0xffADADAD)),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        messages![index].message,
                                        softWrap: true,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 1),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  formatKoreanTime(messages![index].createdAt),
                                  style:
                                      const TextStyle(color: Color(0xffADADAD)),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(width: 10),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(
                                        0xFFFF006B), // Replace with your desired color
                                    Color(
                                        0xFFFF4593), // Replace with your desired color
                                  ],
                                  stops: [0.1097, 0.7357],
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: const Color(0xff323232),
                                ),
                              ),
                              constraints:
                                  BoxConstraints(maxWidth: size.width / 2 + 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 3),
                                  Text(
                                    messages![index].message ?? "",
                                    softWrap: true,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 1),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            height: size.height * .10,
            decoration: const BoxDecoration(
              color: Color(0xff131313),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/add.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xff323232),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(fontSize: 18),
                            onChanged: (text) {
                              onTextChanged();
                            },
                            controller: textController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  top: 15,
                                  left: 20,
                                  bottom: 15,
                                ),
                                border: InputBorder.none,
                                hintText: '메세지 보내기'),
                          ),
                        ),
                        textController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  sendMessage();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFF006A),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Image.asset(
                                    'assets/arrow.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xff3A3A3A),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  'assets/arrow.png',
                                  width: 24,
                                  height: 24,
                                ),
                              )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EventListen extends ChannelEventHandler {
  final Function(UserMessage?)? callback;
  UserMessage? message;

  EventListen(this.callback);
  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    if (message is UserMessage) {
      callback?.call(message);
    } else if (message is FileMessage) {
    } else if (message is AdminMessage) {}
  }
}
