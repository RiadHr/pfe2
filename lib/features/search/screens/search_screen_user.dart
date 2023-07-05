import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../home/widget/loader.dart';
import '../../user/screens/user_detail_screen.dart';
import '../services/search_service.dart';
import '../widgets/searched_patient.dart';

class SearchScreenUser extends StatefulWidget {
  static const String routeName = '/search-screen-user';
  final String searchQuery;

  const SearchScreenUser({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreenUser> createState() => _SearchScreenUserState();
}


class _SearchScreenUserState extends State<SearchScreenUser> {

  List<User>? users;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedUser();
  }

  fetchSearchedUser() async {
    users = await searchServices.fetchSearchedUser(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreenUser(String query) {
    Navigator.pushNamed(context, SearchScreenUser.routeName, arguments: query);
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
                      onFieldSubmitted: navigateToSearchScreenUser,
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
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.notifications, color: Colors.white, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: users == null
          ? const Loader()
          : Column(
        children: [
          // const AddressBox(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UserDetailScreen.routeName,
                      arguments: users![index],
                    );
                  },
                  child: SearchedUser(
                    user: users![index],
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