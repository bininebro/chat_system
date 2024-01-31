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

  @override
  void initState() {
    super.initState();
    // Initialize SendBird SDK
    final sendbird = SendbirdSdk(appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF');
    sendbird.connect('BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF').then((user) {
      final channel = OpenChannel.getChannel(
              'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211')
          .then((channel) {
        channel.enter().then((value) => {});
      }).catchError((e) {
        if (kDebugMode) {
          print("error joining channel" + e.message);
        }
      });
      if (kDebugMode) {
        print("Connected as $user");
      }
    }).catchError((e) {
      if (kDebugMode) {
        print("Error connecting to SendBird: $e");
      }
    });
    // final params = MessageRetrievalParams(
    //     messageId: MESSAGE_ID
    //     channelType: ChannelType.open
    //     channelUrl: CHANNEL_URL
    // );
    //
    // // Pass the params to the parameter of the getMessage() method.
    // final message = await BaseMessage.getMessage(params);
    //
    // var ch = GroupChannel.getChannel(
    //         'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211')
    //     .then((channel) {
    //   print("Connected as $channel");
    // }).catchError((e) {
    //   if (kDebugMode) {
    //     print("error joining channel" + e.message);
    //   }
    // });
    // final channel = OpenChannel.getChannel(
    //         'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211')
    //     .then((channel) {
    //   channel.enter();
    // }).catchError((e) {
    //   if (kDebugMode) {
    //     print("error joining channel" + e.message);
    //   }
    // });

    //
    // try {
    // final params = UserMessageParams(message: MESSAGE)
    //   ..parentMessageId = PARENT_MESSAGE_ID;
    //
    // final result = await channel.sendUserMessage(params);

    //   // use preMessage to populate your chat messages early
    // } catch (e) {
    //   // error
    // }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('name')),
        leading: Icon(Icons.chevron_left, size: 35),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: size.height * .90,
            child: Column(
              children: [
                Container(
                  height: size.height * .80,
                  width: size.width * .9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: size.height * .08,
                  width: size.width * .9,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          size: 30,
                        ),
                        Container(
                          width: size.width * .77,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blueAccent)),
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  width: size.width * .66,
                                  child: const TextField(
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(Icons.arrow_upward),
                                  ))
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
