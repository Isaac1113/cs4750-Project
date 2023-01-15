import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuestPage extends StatefulWidget {
  QuestPage({Key? key, this.gameTitle, this.gameLogo, this.questType, required this.questData}) : super(key: key);

  final gameTitle;
  final gameLogo;
  final questType;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> questData;

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {

  late String _gameTitle;
  late String _gameLogo;
  late String _questType;
  late var _questData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gameTitle = widget.gameTitle;
    _gameLogo = widget.gameLogo;
    _questType = widget.questType;
    _questData = widget.questData;

    print("Printing in quest page initState");
    print(_questData.length);
    _questData.forEach((element) {
      print(element.id);
      print(element.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gameTitle + " Quests"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        _questType + " Quests",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
            ),
            Expanded(
              flex: 90,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _questData?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var date = DateTime.parse(_questData[index]["endtime"].toDate().toString());
                                      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(date);
                                      return AlertDialog(
                                        title: Text(_questData[index].id),
                                        content: Text(
                                            "Description: " + _questData[index]["description"]
                                                + "\n Reward: " + _questData[index]["reward"]
                                                + "\n EndTime: " + formattedDate
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              title: Container(
                                height: 40,
                                margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text('${_questData[index].id}'),
                                    ],
                                  ),
                                ),
                              ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                      ],
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
