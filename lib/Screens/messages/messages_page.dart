import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/utils/constants.dart';
import '../routes/routes.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage>
    with AutomaticKeepAliveClientMixin<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(color: kReSustainabilityRed, width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 0.5),
                ),
                filled: true,
                fillColor: Colors.grey[250],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                  size: 20,
                ),
                hintText: 'search_messages'.tr(),
                hintStyle:
                    TextStyle(color: Colors.grey[400], fontFamily: 'ARIAL'),
              ),
              cursorWidth: 1,
              maxLines: 1,
            ),
          ),
          MessageListItem(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.chatDetail);
            },
            imagePath: 'assets/images/icon_doctor_1.png',
            name: 'Tawfiq Bahri',
            message: 'Your next appointment',
            date: '11:05 AM',
            unread: 10,
            online: false,
          ),
          MessageListItem(
            onTap: () {},
            imagePath: 'assets/images/icon_doctor_3.png',
            name: 'Joseph Bouroumat',
            message: 'Don\'t forget your blood test',
            date: '08:31 AM',
            unread: 2,
            online: true,
          ),
          MessageListItem(
            onTap: () {},
            imagePath: 'assets/images/icon_doctor_2.png',
            name: 'Liza Anderson',
            message: 'You: Good news 😃',
            date: '03:48 PM',
            unread: 0,
            online: false,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MessageListItem extends StatelessWidget {
  final void Function() onTap;
  final String imagePath;
  final String name;
  final String message;
  final String date;
  final int? unread;
  final bool online;

  const MessageListItem({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.name,
    required this.message,
    required this.date,
    this.unread,
    required this.online,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 45,
              height: 45,
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: kReSustainabilityRed,
                    child: FutureBuilder(
                        future: getStringValue('user_name'),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '${snapshot.data.toString()[0]}'.titleCase,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'ARIAL',
                                fontWeight: FontWeight.bold, // italic
                              ),
                            );
                            // your widget
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                  Visibility(
                    visible: online,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(1),
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w700, fontFamily: 'ARIAL'),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'ARIAL'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  date,
                  style: const TextStyle(
                      color: kReSustainabilityRed,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ARIAL'),
                ),
                Visibility(
                  visible: (unread != 0 && unread != null) ? true : false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 7,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: kReSustainabilityRed,
                    ),
                    child: Text(
                      unread.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'ARIAL'),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }
}
