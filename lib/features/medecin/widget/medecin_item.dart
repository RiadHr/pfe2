import 'package:flutter/material.dart';
import 'package:pfe2/constants/utils.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/star.dart';
import '../../../constants/global_variables.dart';
import '../../../models/medecin.dart';
import '../../../providers/user_provider.dart';
import '../../admin/services/admin_service.dart';

class MedecinItem extends StatelessWidget {
  const MedecinItem({
    super.key,
    required this.medecinData,
  });

  final Medecin medecinData;

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    // double totalRating = (medecinData.anciente/10)%1 as double;
    for (int i = 0; i < medecinData.rating!.length; i++) {
      totalRating += medecinData.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      totalRating += (medecinData.anciente / 10);
      avgRating = totalRating / (medecinData.rating!.length + 1);
    } else {
      avgRating = (medecinData.anciente / 10);
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
                  'Dr ${medecinData.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  // overflow: TextOverflow.ellipsis,
                  // maxLines: 2,
                ),
                Text('${medecinData.specialite}'),
                Text('${medecinData.wilaya}'),
              ],
            ),
            if (user.type == 'admin')
              ElevatedButton(
                onPressed: () {
                  print(medecinData.id);
                  adminService.blocklistDoctor(medecinData.id);
                  if(medecinData.isBlocked == true){
                    showSnackBar(context, 'le medecin est retire de la blockliste');
                  }else{
                    showSnackBar(context, 'le medecin est bloquer');
                  }
                },
                child: Icon(Icons.block),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    elevation: 0,
                    fixedSize: Size.fromHeight(60),
                    shape: CircleBorder()),
              ),
            // SizedBox(width: 5)
          ],
        ),
      ),
    );
  }
}
