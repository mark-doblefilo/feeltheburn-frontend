import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeltheburn/ui/widget/app-bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:feeltheburn/models/program.dart';
import 'package:feeltheburn/util/colors.dart';
import 'package:community_material_icon/community_material_icon.dart';

class ProgramScreen extends StatelessWidget {
  final DocumentSnapshot program;

  ProgramScreen({Key key, @required this.program}) : super(key: key);

  DocumentSnapshot set;
  String serieUID;

  Future<DocumentSnapshot> searchSet(String UID) async {
    set = await FirebaseFirestore.instance.collection('serie').doc(UID)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(""),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              program['name'].toUpperCase(),
              style: TextStyle(
                color: TextColor,
                fontWeight: FontWeight.w800,
                fontSize: 28.0,
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.all(6.0),
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: (program['difficulty'] == "Easy")
                    ? EasyBoxColor
                    : (program['difficulty'] == "Medium")
                    ? MediumBoxColor
                    : HardBoxColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                program['difficulty'].toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  fontSize: 10.0,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Icon(
                  CommunityMaterialIcons.bullseye_arrow,
                  color: Colors.white38,
                ),
                SizedBox(width: 5.0),
                Text(
                  program['muscleGroups'].join(", "),
                  style: TextStyle(
                    color: TextColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Icon(
                  CommunityMaterialIcons.progress_clock,
                  color: Colors.white38,
                ),
                SizedBox(width: 5.0),
                Text(
                  program['time'],
                  style: TextStyle(
                    color: TextColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: (program['difficulty'] == "Easy")
                      ? EasyBoxColor
                      : (program['difficulty'] == "Medium")
                          ? MediumBoxColor
                          : HardBoxColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'START TRAINING',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: program['exercises'].length,
              itemBuilder: (context, int index) {
                serieUID = program['exercises'][index];
                print(serieUID);

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
