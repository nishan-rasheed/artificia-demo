import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mydemo/constants/appcolor.dart';
import 'package:mydemo/screens/widgets/homescreen.card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: maxWidth * .03, vertical: maxHeight * .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Learn and Evolve',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                FadeInLeft(
                  duration: Duration(seconds: 2),
                  from: 800,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: maxHeight * .22,
                        width: maxWidth,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Image.asset(
                          'assets/images/asif.png',
                          height: maxHeight * .24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: maxHeight * .03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: maxWidth * .4,
                                child:const Text(
                                  'Become Master in Data Science',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: maxHeight * .05,
                              ),
                              const Text(
                                'By Asif Abduraheem',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                const Padding(
                  padding:EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Featured Courses',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                FadeInRight(
                  duration:const Duration(seconds: 2),
                  from: 800,
                  child:const HomescreenCard()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Show More',style: TextStyle(color: AppColor.primary,
                      fontSize:16,fontWeight: FontWeight.w600
                    ),)),
                ),
                FadeInLeft(
                  duration:const Duration(seconds: 2),
                  from: 800,
                  child: Image.asset('assets/images/slider.png')),
                const Padding(
                  padding:EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Courses',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                StreamBuilder(
                  stream:FirebaseFirestore.instance.collection('courses').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox(
                        height: 50,
                        child: Center(child: CircularProgressIndicator()));
                    }
                    return ListView.separated(
                      physics:const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10,);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var courseList ;
                        courseList = snapshot.data!.docs[index].data();
                        return Row(
                          children: [
                            Container(
                              height: maxHeight*.13,width: maxWidth*.4,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(courseList['thumbnail'].toString()))
                              ),
                            ),
                            const SizedBox(width:10,),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text(courseList['title'],style:const TextStyle(
                                    fontSize: 18,fontWeight: FontWeight.w700
                                  ),),
                                  const SizedBox(height: 10,),
                                  Text('By ${courseList['author']}'),
                                ],
                              ),
                            )
                          ],
                        ) ;
                      },
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

