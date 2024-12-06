import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pgapp/di/locator.dart';
import 'package:pgapp/features/annoucement/model/AnnoucementModel.dart';
import 'package:pgapp/features/annoucement/presentation/AnnoucementLog_Page.dart';
import 'package:pgapp/services/dataService/annoucementService.dart';

import '../../../core/constants/ColorConstants.dart';
import '../../../core/constants/constants.dart';
import '../../../utils/Utils.dart';

class AnnoucementScreen extends StatefulWidget {
  const AnnoucementScreen({super.key});

  @override
  State<AnnoucementScreen> createState() => _AnnoucementScreenState();
}

class _AnnoucementScreenState extends State<AnnoucementScreen> {

  final AnnoucementService _annoucementService = locator<AnnoucementService>();

  void _addToServer(String text, String text2) {
    String formatedDate = dateFormatter();
    Annoucement a = Annoucement(
        title: text, description: text2, datetime: formatedDate);

    //Call to server
    _sendToServer(a);
  }

  Future<void> _sendToServer(Annoucement a) async{

    bool res = await _annoucementService.addToAnnoucementList(a);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Annoucement has been made!"),
        backgroundColor: Colors.green,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Annoucement"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            customAnnoucementWidget(context,"Make Annoucement",(){
              announcementModalBottomsheet(context);
            }),
            SH30,
            customAnnoucementWidget(context,"Annoucement Logs",(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AnnoucementLogScreen(isAdmin: true,) ));
            }),
            SH30,
          ],
        ),
      ),
    );
  }

  GestureDetector customAnnoucementWidget(BuildContext context,String text,Function customFunction) {
    return GestureDetector(
            onTap: (){
              customFunction();
            },
            child: Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: CustomColors.secondary1,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    color: Colors.black26,
                  ),
                ],
              ),
              child:  Center(
                  child: Text(
                "$text",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                ),
              )),
            ),
          );
  }

  Future<dynamic> announcementModalBottomsheet(BuildContext context) {
    return showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController title = TextEditingController();
                    TextEditingController description =
                        TextEditingController();

                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          TextField(
                            controller: title,
                            decoration: const InputDecoration(
                              hintText: "Title",
                              hintFadeDuration: Duration(milliseconds: 100),
                              helperMaxLines: 45,
                              errorMaxLines: 45,
                            ),
                            maxLength: 45,
                          ),
                          SH30,
                          TextField(
                            controller: description,
                            decoration: const InputDecoration(
                              hintText: "Message",
                              hintFadeDuration: Duration(milliseconds: 100),
                              helperMaxLines: 200,
                              errorMaxLines: 200,
                            ),
                            maxLength: 200,
                          ),
                          SH30,
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _addToServer(title.text, description.text);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Announce",
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Cancel",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
  }
}
