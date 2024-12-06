
import 'package:flutter/material.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';
import 'package:pgapp/di/locator.dart';
import 'package:pgapp/features/annoucement/model/AnnoucementModel.dart';
import 'package:pgapp/services/dataService/annoucementService.dart';

import '../../../core/constants/constants.dart';
import '../../../utils/Utils.dart';

class AnnoucementLogScreen extends StatefulWidget {
  final bool isAdmin;
  const AnnoucementLogScreen({super.key,required this.isAdmin});

  @override
  State<AnnoucementLogScreen> createState() => _AnnoucementLogScreenState();
}

class _AnnoucementLogScreenState extends State<AnnoucementLogScreen> {
  final AnnoucementService _annoucementService = locator<AnnoucementService>();
  List<Annoucement>? ls;

  // bool isAdmin = true; //TODO: NNED TO CHANGE AFTER USER LOGIN, WITH ROLES

  Future<void> _getAnnoucementList() async {
    var res = await _annoucementService.getAnnoucements();

    setState(() {
      ls = res;
    });
  }

  void editAnnoucement(Annoucement a){
    announcementModalBottomsheet(context,a);
  }

  void _saveToServer(String title,String desc,String oldDatetime){
    String formatedDate = dateFormatter();
    Annoucement a = Annoucement(
        title: title, description: desc, datetime: oldDatetime);

    //Call to server
    _SendToUpdateServer(a);
  }

  void _SendToUpdateServer(Annoucement a) async{
    bool res = await _annoucementService.updateAnnoucement(a);
    if(res){
      CustomToaster(context,"Annoucement Updated Successfully",Colors.yellowAccent,Colors.black87);
    }
  }

  void _deleteAnnoucement(Annoucement a) async{
    bool res = await _annoucementService.deleteAnnocument(a);
    if(res){
      CustomToaster(context, "Annoucement Deleted Successfully", Colors.red,Colors.black87);
    }
    setState(() {
      ls?.removeWhere((element) => element.datetime == a.datetime);
    });
  }


  @override
  void initState() {
    super.initState();
    _getAnnoucementList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Annoucement Logs"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: ls == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: ls!.length,
                  itemBuilder: (context, index) {
                    Annoucement a = ls![index];
                    return customAnnoucemntCard(a);
                  })),
    );
  }

  Padding customAnnoucemntCard(Annoucement a) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 250,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: CustomColors.primary1,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 0.8,
                  spreadRadius: 0.2,
                  offset: Offset(4, 4),
                  color: Colors.black87)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SH10,
             Text(
              "${a.datetime}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SH30,
             Text(
              "${a.title}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SH10,
             Text(
              "${a.description}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3, // Limit to a maximum of 3 lines (adjust if needed)
              overflow:
                  TextOverflow.ellipsis, // Add "..." if text exceeds maxLines
              softWrap: true, // Allow text to wrap onto the next line
            ),
            SH30,
            if (widget.isAdmin)
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      editAnnoucement(a);
                    },
                    child: const Text("Edit"),
                  ),
                  const Spacer(),
                  ElevatedButton(onPressed: () {
                    showDialog(context: context, builder: (contex){
                      return AlertDialog(
                        title: Text("Deletion Confirmation"),
                        content: Text("Are you sure you want to delete"),
                        actions: [
                          ElevatedButton(onPressed: (){
                            _deleteAnnoucement(a);
                            Navigator.pop(context);
                          }, child: Text("Yes")),
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("Cancel"))
                        ],
                      );
                    });
                  }, child: const Text("Delete"))
                ],
              ),
          ],
        ),
      ),
    );
  }

//   will refactor once done
  Future<dynamic> announcementModalBottomsheet(BuildContext context,Annoucement a) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          TextEditingController title = TextEditingController(
            text: a.title
          );
          TextEditingController description =
          TextEditingController(
            text: a.description
          );

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: title,
                  decoration:  const InputDecoration(
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
                  decoration:  const InputDecoration(
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
                        setState(() {
                          a.title = title.text;
                          a.description = description.text;
                        });
                        _saveToServer(title.text, description.text,a.datetime);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Save",
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
