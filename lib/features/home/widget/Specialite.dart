import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../screens/medecin_specialite_screen.dart';

// a scrobale wiget that display the specialite of medecins
class Specialite extends StatelessWidget {
  const Specialite({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, MedecinSpecialiteScreen.routeName,arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        itemCount: GlobalVariables.specialite.length,
        scrollDirection: Axis.horizontal,
        // itemExtent: 160,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
              context,
              GlobalVariables.specialite[index]!,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  decoration: kItemSpecialiteDecoration,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      GlobalVariables.specialite[index]!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },separatorBuilder: (BuildContext context, int index) =>
      const Divider(height: 3, color: Colors.white),
      ),
    );
  }
}