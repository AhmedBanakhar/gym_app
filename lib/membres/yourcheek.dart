import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class YourCheek extends StatefulWidget {
  const YourCheek({super.key});

  @override
  State<YourCheek> createState() => _YourCheekState();
}

class _YourCheekState extends State<YourCheek> {
  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
    body: ListView(
      children: [
        Card(
           color: Colors.grey[200],
           borderOnForeground: false,
          clipBehavior: Clip.hardEdge,
        
                   margin: EdgeInsets.all(20),
                   elevation: 20.0,
                   shadowColor: Colors.grey.withOpacity(0.9),
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.grey),
                  ),
          child: const Row(
            children: [
                InstaImageViewer(
        
                     child: ClipRRect(
                      // clipBehavior: ,
                       
                     // borderRadius: BorderRadius.circular(20),
                      child: Image(image: AssetImage("images/٢٠٢٤٠٥٠٤_٠١٢٢٢٨.jpg"),width: 150,height: 130,),
                    )
                    
                    ),
                     // ignore: unnecessary_const
                     const SizedBox(
                   width: 30,
                  ),
              const Text('Date:11/4/2024',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
     
          
            ],))
      
      ]),);
   /* backgroundColor: Colors.white,
    body: Column(
      children: [
        Container(
          height: 230,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            ) ,   
            color: Color(0xFF363f93),
            
            
              ),
           child: Stack(
            children: [
              Positioned(
                top: 80,
                left: 0,
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                     topRight: Radius.circular(50),
                     bottomRight: Radius.circular(50),
                    ),
                    
                  ),
                )
                
                
                ),
                const Positioned(
                  top: 110,
                  left: 20,
                  child: Text('Your Cheek',style: TextStyle(fontSize: 30,color: Color(0xFF363f93)),))
            ],),
        ),
        SizedBox(height: height*0.05,),
        Container(
          height: 230,
          child: Stack(
            children: [
             
              Positioned(
               top: 35,
               left: 20,
                child: Material(
               child:Container(
               height: 180.0,
                width: width * 0.9,
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0.0),
                 boxShadow: [
                  BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                 offset: const Offset(-10.0, 10.0),
                    blurRadius: 20.0,
                   spreadRadius: 4.0
                )
              ]
            ),
            //child: Text(''),
          ),

      ) ),
          Positioned(
            top: 0,
            left: 30,
            child: Card(
            elevation: 10.0,
            shadowColor: Colors.grey.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                
                image:const DecorationImage(
                  fit: BoxFit.fill,
                  image:AssetImage('images/waters.jpg') )
              ),
            ),  
            
            
            )),
            Positioned(
              top: 60,
              left: 200,
              child: Container(
                height: 150,
                width: 160,
                child:const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 Text('Cups of Waters',style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF363f93),
                  fontWeight: FontWeight.bold),),

                  Text('Sorrento Lemon Chicken,Healthy Sheet Pan Sausage & Veggies,',style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),),
                  Divider(color: Colors.black,),
                   Text('Time: 11:25',style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),),
                ]) ,
              )),
              
          ]
          ),
        ),
        Expanded(
          child:MediaQuery.removePadding(
          context: context,
          removeTop: true, 
          child: ListView(
                  children: [
                   Container(
  margin: const EdgeInsets.only(bottom: 10, top: 25),
  height: 300,
  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
  child: Container(
    decoration: BoxDecoration(
      color: const Color(0xFf363f93),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(80.0),
       // bottomRight: Radius.circular(80.0),
          topRight: Radius.circular(80.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: const Offset(-10.0, 10.0),
          blurRadius: 20.0,
          spreadRadius: 4.0
        )
      ]
    ),
    padding: const EdgeInsets.only(
      left: 32,
      top: 50.0,
      bottom: 50,                            
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(-10.0, 10.0),
                blurRadius: 20.0,
                spreadRadius: 4.0
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(image: AssetImage('images/lunch.jpg'), fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 10),
        const Expanded(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Break Fast:", style: TextStyle(color: Colors.white, fontSize: 17)),
              SizedBox(height: 4),
              Text('Sweet Potato Stovies',
              
                textAlign: TextAlign.left,
               
                style: TextStyle(color: Colors.white, fontSize: 12),
                overflow: TextOverflow.clip,
                maxLines: 10,
              ),
             
               SizedBox(height: 4),
               Text("Snack_1:", style: TextStyle(color: Colors.white, fontSize: 15)),
               SizedBox(height: 2),
               Text("Banana", style: TextStyle(color: Colors.white, fontSize: 12)),
               SizedBox(height: 6),
                Text("Snack_1_Time: 05:30:17", style: TextStyle(color: Colors.white, fontSize: 12)),
                Text("Time_BreakFast: 05:30:17", style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
          ),
        ),
      ],
    ),
  ),
),
                       Container(
  margin: const EdgeInsets.only(bottom: 10, top: 25),
  height: 300,
  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
  child: Container(
    decoration: BoxDecoration(
      color: const Color(0xFf363f93),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(80.0),
       // bottomRight: Radius.circular(80.0),
          topRight: Radius.circular(80.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: const Offset(-10.0, 10.0),
          blurRadius: 20.0,
          spreadRadius: 4.0
        )
      ]
    ),
    padding: const EdgeInsets.only(
      left: 32,
      top: 50.0,
      bottom: 50,                            
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(-10.0, 10.0),
                blurRadius: 20.0,
                spreadRadius: 4.0
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(image: AssetImage('images/lunch.jpg'), fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 10),
        const Expanded(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              Text("Lunch:", style: TextStyle(color: Colors.white, fontSize: 17)),
              SizedBox(height: 4),
              Text('Sweet Potato Stovies',
              
                textAlign: TextAlign.left,
               
                style: TextStyle(color: Colors.white, fontSize: 12),
                overflow: TextOverflow.clip,
                maxLines: 10,
              ),
             
               SizedBox(height: 4),
               Text("Snack_2:", style: TextStyle(color: Colors.white, fontSize: 15)),
               SizedBox(height: 2),
               Text("Banana", style: TextStyle(color: Colors.white, fontSize: 12)),
               SizedBox(height: 6),
                Text("Snack_2_Time: 05:30:17", style: TextStyle(color: Colors.white, fontSize: 12)),
                Text("Time_Lunch: 05:30:17", style: TextStyle(color: Colors.white, fontSize: 12)),
              
            ],
          ),
        ),
      ],
    ),
  ),
)





                  ],
                )))
      ]),*/
   

  }
}
