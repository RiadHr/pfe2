import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/star.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/medecin.dart';
import '../../../providers/user_provider.dart';
import '../../appointment/screen/booking_screen.dart';
import '../../search/screens/search_screen.dart';
import '../services/medecin_detail_service.dart';

class MedecinDetailScreen extends StatefulWidget {
  static const String routeName = '/medecin-details';
  final Medecin medecin;
  const MedecinDetailScreen({
    Key? key,
    required this.medecin,
  }) : super(key: key);

  @override
  State<MedecinDetailScreen> createState() => _MedecinDetailScreenState();
}

class _MedecinDetailScreenState extends State<MedecinDetailScreen> {
  final MedecinDetailsServices medecinDetailsServices =
      MedecinDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.medecin.rating!.length; i++) {
      totalRating += widget.medecin.rating![i].rating;
      if (widget.medecin.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.medecin.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.medecin.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.firstColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),

                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.medecin.id,
                  ),
                  Stars(
                    rating: avgRating,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text('Dr ${widget.medecin.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Specialite : ',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '${widget.medecin.specialite}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: GlobalVariables.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    text: 'Email : ',
                    children: [
                      TextSpan(
                          style:TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          text: widget.medecin.email,
                      ),
                    ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () async {
                  final Uri url = Uri(
                    scheme: 'tel',
                    path: widget.medecin.telephone
                  );
                  if(await canLaunchUrl(url)){
                    await launchUrl(url);
                  }else{
                    showSnackBar(context,'cannot launch phone number');
                  }
                },
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      text: 'Telephone : ',
                      children: [
                        TextSpan(
                          style:TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          text: widget.medecin.telephone,
                        ),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    text: 'wilaya : ',
                    children: [
                      TextSpan(
                        style:TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        text: widget.medecin.wilaya,
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    text: 'daira : ',
                    children: [
                      TextSpan(
                        style:TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        text: widget.medecin.daira,
                      ),
                    ]),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                alignment: AlignmentDirectional.center,
                // margin: EdgeInsets.symmetric(horizontal: 100),
                // decoration:BoxDecoration(
                //   border: Border.all(
                //       width: 2,
                //       style: BorderStyle.solid,
                //       color: Colors.black),
                // ),
                child: CustomButton(
                  text: 'faire une visite medicale',
                  onTap: () {
                    setState(() {
                      var user = Provider.of<UserProvider>(context,listen: false).user;
                      if(!user.isBlacklisted!.contains(widget.medecin.id)) {
                        Navigator.pushNamed(context, BookingScreen.routeName,
                            arguments: widget.medecin);
                      }
                      if(user.isBlacklisted!.contains(widget.medecin.id)) {
                        showSnackBar(context,
                            'vous etes blocker par ce medecin');
                      }
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Rate The Medecin',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if(!user.isBlacklisted!.contains(widget.medecin.id))
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                medecinDetailsServices.rateMedecin(
                  context: context,
                  medecin: widget.medecin,
                  rating: rating,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}


