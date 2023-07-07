import 'package:flutter/material.dart';
import '../../../common/widgets/star.dart';
import '../../../constants/global_variables.dart';
import '../../../models/medecin.dart';

class SearchedMedecin extends StatelessWidget {
  final Medecin medecin;
  const SearchedMedecin({
    Key? key,
    required this.medecin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < medecin.rating!.length; i++) {
      totalRating += medecin.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / medecin.rating!.length;
    }
    return Column(
      children: [
        Container(
          decoration: kItemListDecoration,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                color: Colors.white,
                width: 80,
                height: 80,
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
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      medecin.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //         width: 2,
                    //         style: BorderStyle.solid,
                    //         color: Colors.black),
                    // ),
                    width: 235,
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.only(left: 5),
                    child: Stars(
                      rating: avgRating,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '${medecin.specialite}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('${medecin.wilaya}'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}