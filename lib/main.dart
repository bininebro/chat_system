import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff0E0D0D),
        appBarTheme: AppBarTheme(color: Color(0xff0E0D0D)),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final sb = SendbirdSdk();

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //  initData();
  }

  sendMessage() async {
    if (textController.text.isNotEmpty) {
      var messages = await channel?.getMessagesByTimestamp(
          DateTime.now()
              .subtract(const Duration(days: 2))
              .millisecondsSinceEpoch,
          MessageListParams());
      var mes = UserMessageParams(message: textController.text);
      textController.clear();
      var messa = await channel?.sendUserMessage(mes);
    }
  }

  OpenChannel? channel;
  bool isPerson = true;
  initData() async {
    final sendbird = SendbirdSdk(appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF');
    var users = await sendbird.connect('BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF');
    channel = await OpenChannel.getChannel(
        "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211");
    channel?.enter();
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
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: size.height * .90,
            child: Column(
              children: [
                Container(
                  height: size.height * .80,
                  width: size.width * .9,
                  decoration: const BoxDecoration(
                    color: Color(0xff0E0D0D),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isPerson
                          ? Row(
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
                                      padding: const EdgeInsets.only(
                                          bottom: 4, left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1A1A1A),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        border: Border.all(
                                            color: const Color(0xff323232)),
                                      ),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'fgdfgfd',
                                            style: TextStyle(
                                                color: Color(0xffADADAD)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'fgdfgf  sdfdfd dsfsdfdsfd',
                                            softWrap: true,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(height: 1),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'text',
                                      style:
                                          TextStyle(color: Color(0xffADADAD)),
                                    ),
                                  ],
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(width: 10),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.only(
                                      bottom: 4, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1A1A1A),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    border: Border.all(
                                        color: const Color(0xff323232)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 3),
                                      Container(
                                        width: size.width * .5,
                                        child: const Text(
                                          'fsfsddddddddddd sdfdsfdsddsfdsfds  sdfdfd dsfsdfdsfd',
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                    ],
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
                Container(
                  height: size.height * .10,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xff131313),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset('assets/add.png'),
                        const SizedBox(width: 5),
                        Container(
                          width: size.width * .87,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(color: const Color(0xff323232))),
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  width: size.width * .76,
                                  child: TextField(
                                    style: TextStyle(fontSize: 18),
                                    onChanged: (text) {
                                      print('Text changed: $text');
                                      onTextChanged();
                                    },
                                    controller: textController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                              textController.text.isNotEmpty
                                  ? Container(
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF006A),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            sendMessage();
                                          },
                                          child:
                                              Image.asset('assets/arrow.png'),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff3A3A3A),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.arrow_upward),
                                      ),
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
