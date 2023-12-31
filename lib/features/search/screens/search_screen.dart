import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../../../models/medecin.dart';
import '../../home/widget/loader.dart';
import '../../medecin/screens/medecin_detail_screen.dart';
import '../services/search_service.dart';
import '../widgets/searched_medecin.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String? searchQuery;
  final String? specailite;

  const SearchScreen({
    Key? key,
    required this.searchQuery, required this.specailite,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {

  List<Medecin>? medecins;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedMedecin();
  }

  fetchSearchedMedecin() async {
    medecins = await searchServices.fetchSearchedMedecin(
        context: context, searchQuery: widget.searchQuery,specialite: widget.specailite);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
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
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search',
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
      body: medecins == null
          ? const Loader()
          : Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: medecins!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MedecinDetailScreen.routeName,
                      arguments: medecins![index],
                    );
                  },
                  child: SearchedMedecin(
                    medecin: medecins![index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}