import 'package:flutter/material.dart';
// import 'package:login_register/models/constant.dart';
import 'package:login_register/models/product.dart';

class BodyDetails extends StatelessWidget {
  final Product product;
  const BodyDetails({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.maybeOf(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  makeItem(image: 'assets/images/analog1.jpg'),
                  makeItem(image: 'assets/images/analog2.jpg'),
                  makeItem(image: 'assets/images/analog3.jpg'),
                  makeItem(image: 'assets/images/analog4.jpg'),
                  makeItem(image: 'assets/images/analog8.jpg'),
                  makeItem(image: 'assets/images/analog9.jpg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget makeItem({image}) {
  return AspectRatio(
    aspectRatio: 1 / 1,
    child: Container(
      margin: EdgeInsets.only(right: 10, top: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 6.0),
        ],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Colors.black45,
            BlendMode.darken,
          ),
        ),
      ),
    ),
  );
}
            // child: ListView.builder(
            //   controller: scrollController,
            //   itemCount: 2,
            //   itemBuilder: (BuildContext context, int index) {
            //     return ListTile(
            //       leading: const Icon(Icons.ac_unit),
            //       title: Text('Item $index'),
            //     );
            //   },
            // ),
// SingleChildScrollView(
//         child: Column(
//           children: [
//             // SizedBox(
//             //   height: size.height * 1,
//             //child:
//             Stack(
//               children: [
//                 Container(
//                     margin: EdgeInsets.only(top: size.height * 0.3),
//                     height: size.height * 0.6,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                       ),
//                     )),
//                 Column(
//                   children: [
//                     SizedBox(height: 300),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: kDefaultPaddin),
//                       child: Text(
//                         product.description,
//                         style: TextStyle(height: 1.5),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Laboratorium Teknik",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       Text(
//                         product.title,
//                         style: Theme.of(context).textTheme.headline4.copyWith(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 200),
//                       Row(
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "${product.price}",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline5
//                                       .copyWith(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             //)
//           ],
//         ),
//       ),