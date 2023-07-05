import 'package:flutter/material.dart';

import '../../../common/widgets/star.dart';
import '../../../constants/global_variables.dart';
import '../../../models/pharmacien.dart';

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

    return Container(
      decoration: kItemListDecoration,
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              // backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
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
          )
        ],
      ),
    );
  }
}