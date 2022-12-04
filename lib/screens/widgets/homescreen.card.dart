import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mydemo/constants/appcolor.dart';

class HomescreenCard extends StatelessWidget {
  const HomescreenCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: maxHeight * .4,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('courses').snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
             return const SizedBox(
                        height: 50,
                        child: Center(child: CircularProgressIndicator()));
          }
          return ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
               var item;
               item = snapshot.data!.docs[index].data();

              return Container(
                width: maxWidth * .7,
                margin:const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade50,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:const EdgeInsets.only(right: 10,top: 10),
                      height: maxHeight * .25,width: maxWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  item['thumbnail'].toString()))),
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                               Container(
                                padding:const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child:const Icon(Icons.bookmark_border,color: Colors.white,),
                               ),
                               ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  foregroundColor: Colors.white
                                ), 
                                child:const Text('Enroll'))
                            ],
                          ),        
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'].toString(),
                            style:const TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.person,color: Colors.grey,),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(item['author'].toString(),style:const TextStyle(
                                  color: Colors.grey,fontWeight: FontWeight.w600
                                ),),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(item['price']+' \u20B9',style:const TextStyle(
                                    color: AppColor.primary,fontWeight: FontWeight.bold
                                  ),),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                  padding:const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(15),
                                    color:const Color.fromARGB(255, 213, 195, 234),
                                  ),
                                  child:const Text('Best Seller',style: TextStyle(
                                    color: AppColor.primary,fontWeight: FontWeight.bold
                                  ),))
                            ],
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }
}
