// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:pfe_app/features/auth/services/auth_service.dart';
// import '../../../common/widgets/custom_button.dart';
// import '../../../common/widgets/custom_textfield.dart';
// import '../../../constants/global_variables.dart';
// import '../../../constants/utils.dart';
//
// class ProfileUserScreen extends StatefulWidget {
//   static const String routeName = '/profile_user';
//   const ProfileUserScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileUserScreen> createState() => _ProfileUserScreenState();
// }
//
// class _ProfileUserScreenState extends State<ProfileUserScreen> {
//   AuthService authService = AuthService();
//   final TextEditingController productNameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   Color defaultColor = GlobalVariables.firstColor;
//
//   String category = 'Mobiles';
//   List<File> images = [];
//   final _addProductFormKey = GlobalKey<FormState>();
//
//   @override
//   void dispose() {
//     super.dispose();
//     productNameController.dispose();
//     descriptionController.dispose();
//     priceController.dispose();
//     quantityController.dispose();
//   }
//
//   List<String> productCategories = [
//     'Mobiles',
//     'Essentials',
//     'Appliances',
//     'Books',
//     'Fashion'
//   ];
//
//   // void sellProduct() {
//   //   if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
//   //     adminServices.sellProduct(
//   //       context: context,
//   //       name: productNameController.text,
//   //       description: descriptionController.text,
//   //       price: double.parse(priceController.text),
//   //       quantity: double.parse(quantityController.text),
//   //       category: category,
//   //       images: images,
//   //     );
//   //   }
//   // }
//
//   void selectImages() async {
//     var res = await pickImages();
//     setState(() {
//       images = res;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               color: GlobalVariables.firstColor,
//             ),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: 120,
//                 height: 55,
//                 child: Image(
//                   image: AssetImage('images/tabibi.png'),
//                 ),
//               ),
//               SizedBox(
//                 width: 40,
//               ),
//               TextButton(
//                 style: ButtonStyle(backgroundColor:MaterialStateProperty.all(defaultColor)),
//                 onPressed: (){
//                   setState(() {
//                     defaultColor = defaultColor != GlobalVariables.secondaryColor ? GlobalVariables.secondaryColor : GlobalVariables.firstColor ;
//                     authService.logOut(context);
//                   });
//                 },
//                 child: Text(
//                   'Se déconnecter',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _addProductFormKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 images.isNotEmpty
//                     ? CircleAvatar(
//                   child: Image(image: NetworkImage()),
//                 )
//                     : GestureDetector(
//                   onTap: selectImages,
//                   child: DottedBorder(
//                     borderType: BorderType.RRect,
//                     radius: const Radius.circular(10),
//                     dashPattern: const [10, 4],
//                     strokeCap: StrokeCap.round,
//                     child: Container(
//                       width: double.infinity,
//                       height: 150,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.folder_open,
//                             size: 40,
//                           ),
//                           const SizedBox(height: 15),
//                           Text(
//                             'Select Product Images',
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey.shade400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 CustomTextField(
//                   controller: productNameController,
//                   hintText: 'Product Name',
//                 ),
//                 const SizedBox(height: 10),
//                 CustomTextField(
//                   controller: descriptionController,
//                   hintText: 'Description',
//                   maxLines: 7,
//                 ),
//                 const SizedBox(height: 10),
//                 CustomTextField(
//                   controller: priceController,
//                   hintText: 'Price',
//                 ),
//                 const SizedBox(height: 10),
//                 CustomTextField(
//                   controller: quantityController,
//                   hintText: 'Quantity',
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.infinity,
//                   child: DropdownButton(
//                     value: category,
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     items: productCategories.map((String item) {
//                       return DropdownMenuItem(
//                         value: item,
//                         child: Text(item),
//                       );
//                     }).toList(),
//                     onChanged: (String? newVal) {
//                       setState(() {
//                         category = newVal!;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 CustomButton(
//                   text: 'Sell',
//                   onTap: sellProduct,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }