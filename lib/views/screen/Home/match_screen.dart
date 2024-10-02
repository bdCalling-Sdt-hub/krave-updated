// import 'package:flutter/material.dart';
//
// class MatchScreen extends StatelessWidget {
//   const MatchScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krave/utils/app_colors.dart';

import '../../../helpers/route.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF3E6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/female.png'),
                  ),
                  SizedBox(width: 16),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/male.png'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Congratulations",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "It's a match, Jane!!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
               Text(
                "Here's some restaurant recommendation.",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRestaurantCard(
                      context,
                      'assets/images/restaurant.png',
                      'Turkish Balloon Café',
                      '2 km Away',
                    ),
                    const SizedBox(width: 8),
                    _buildRestaurantCard(
                      context,
                      'assets/images/restaurant.png',
                      'Turkish Balloon Café',
                      '2 km Away',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Text('Start a conversation now with each other '),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF8400), // Background color
                  minimumSize: Size(double.infinity, 58),
                  shape: RoundedRectangleBorder(

                  ),
                ),
                child: Text(
                  "Say Hello!",
                  style: TextStyle(fontSize: 18,color: AppColors.backgroundColor),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.homeScreen);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor:AppColors.primaryColor,
                  backgroundColor: AppColors.borderColors, // Text color
                  side: BorderSide(color: Colors.orange),
                  minimumSize: Size(double.infinity, 58),
                  shape: RoundedRectangleBorder(

                  ),
                ),
                child: Text(
                  "Back to home",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              // SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(
      BuildContext context, String imagePath, String name, String distance) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: 210.h,
        width: 239.w,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100,
              ),
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on,
                    color: AppColors.subTextColor, size: 16),
                SizedBox(width: 4),
                Text(
                  distance,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}