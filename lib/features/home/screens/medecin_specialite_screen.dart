import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/medecin.dart';
import '../../medecin/screens/medecin_detail_screen.dart';
import '../../medecin/widget/medecin_item.dart';
import '../../search/screens/search_screen.dart';
import '../services/home_service.dart';
import '../widget/loader.dart';

class MedecinSpecialiteScreen extends StatefulWidget {
  static const String routeName = '/api/medecin_specialite/';
  final String specialite;
  const MedecinSpecialiteScreen({
    Key? key,
    required this.specialite,
  }) : super(key: key);

  @override
  State<MedecinSpecialiteScreen> createState() =>
      _MedecinSpecialiteScreenState();
}

class _MedecinSpecialiteScreenState extends State<MedecinSpecialiteScreen> {
  List<Medecin>? medecinList;
  final HomeService homeServices = HomeService();

  @override
  void initState() {
    super.initState();
    fetchMedecinSpecialites();
  }

  void navigateToSearchScreen(String query) {
    // Map<String, dynamic> arguments = {
    //   'query': query,
    //   'specialite': widget.specialite,
    // };
    // print('argumet ${arguments["specialite"]} ${arguments["query"]}');
    Navigator.pushNamed(context, SearchScreen.routeName, arguments:{
      'query': query,
      'specialite': widget.specialite,
    },);
  }

  fetchMedecinSpecialites() async {
    medecinList = await homeServices.fetchMedecinSpecialites(
      context: context,
      specialite: widget.specialite,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            color: GlobalVariables.firstColor,
          ),
          title:  Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  // margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'rechercher par nom ou par localisation ',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20,)
            ],
          ),
        ),
      ),
      body: medecinList == null
          ? const Loader()
          : ListView.builder(
            itemCount: medecinList!.length,
            itemBuilder: (context, index) {
              final int i = index;
              final medecinData = medecinList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, MedecinDetailScreen.routeName,
                      arguments: medecinList![index]);
                },
                child: MedecinItem(medecinData: medecinData),
              );
            },
          ),
    );
  }
}