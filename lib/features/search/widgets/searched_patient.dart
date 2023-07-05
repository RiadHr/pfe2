import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';


class SearchedUser extends StatelessWidget {
  final User user;
  const SearchedUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double totalRating = 0;
    // for (int i = 0; i < user.rating!.length; i++) {
    //   totalRating += user.rating![i].rating;
    // }
    // double avgRating = 0;
    // if (totalRating != 0) {
    //   avgRating = totalRating / user.rating!.length;
    // }
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
              // Image.network(
              //   user.images[0],
              //   fit: BoxFit.contain,
              //   height: 135,
              //   width: 135,
              // ),
              Container(
                // color: Colors.grey,
                width: 80,
                height: 80,
                child: CircleAvatar(
                  child: Icon(
                    Icons.account_circle,
                    // color:Colors.grey ,
                    size: 80,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  // Container(
                  //   width: 235,
                  //   padding: const EdgeInsets.only(left: 10, top: 5),
                  //   child: Stars(
                  //     rating: avgRating,
                  //   ),
                  // ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '${user.telephone}',
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
                    child: Text('${user.name}'),
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