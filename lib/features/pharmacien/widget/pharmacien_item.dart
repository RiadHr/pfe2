import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/star.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/pharmacien.dart';
import '../../../providers/user_provider.dart';
import '../../admin/services/admin_service.dart';

class PharmacienItem extends StatelessWidget {
  const PharmacienItem({
    super.key,
    required this.pharmacienData,
  });

  final Pharmacien pharmacienData;

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    // double totalRating = (pharmacienData.anciente/10)%1 as double;
    for (int i = 0; i < pharmacienData.rating!.length; i++) {
      totalRating += pharmacienData.rating![i].rating;
    }
    double avgRating=0;
    if (totalRating != 0) {
      totalRating += (pharmacienData.anciente/10);
      avgRating = totalRating / (pharmacienData.rating!.length + 1);
    }
    else{
      avgRating = (pharmacienData.anciente/10);
    }
    AdminService adminService = AdminService();
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: kItemListDecoration,
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                // border: Border.all(
                //     width: 2,
                //     style: BorderStyle.solid,
                //     color: Colors.black),
              ),
              width: 80,
              height: 80,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(right: 40),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 60,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //       width: 2,
                  //       style: BorderStyle.solid,
                  //       color: Colors.black),
                  // ),
                  // decoration: kItemListDecoration,
                  // width: 235,
                  // padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Stars(
                    rating: avgRating,
                  ),
                ),
                Text(
                  '${pharmacienData.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  // overflow: TextOverflow.ellipsis,
                  // maxLines: 2,
                ),
                Text('${pharmacienData.wilaya}'),

              ],
            ),
            if (user.type == 'admin')
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print(pharmacienData.id);
                      adminService.permanancelistPharmacien(pharmacienData.id);
                      if(pharmacienData.permanance == true){
                        showSnackBar(context, 'le pharmacien est retire de la list des permanances ');
                      }else{
                        showSnackBar(context, 'le pharmacien est ajouter de la list des permanances ');
                      }
                    },
                    child: Icon(FontAwesomeIcons.solidMoon),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade900,
                        elevation: 0,
                        fixedSize: Size.fromHeight(40),
                        shape: CircleBorder()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(pharmacienData.id);
                      adminService.blocklistPharmacien(pharmacienData.id);
                      if(pharmacienData.isBlocked == true){
                        showSnackBar(context, 'le pharmacien est retire de la permananceliste');
                      }else{
                        showSnackBar(context, 'le pharmacien est ajouter au permananceliste');
                      }
                    },
                    child: Icon(Icons.block),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        elevation: 0,
                        fixedSize: Size.fromHeight(40),
                        shape: CircleBorder()),
                  ),

                ],
              ),

          ],
        ),
      ),
    );
  }
}