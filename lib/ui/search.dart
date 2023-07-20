import 'package:flutter/material.dart';
import 'package:restaurant_api/model/restaurant.dart';

import '../../core/api_client.dart';

class Search extends SearchDelegate {
  final ApiClient _apiClient = ApiClient();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future<RestaurantResult> search() async {
      RestaurantResult userRes = await _apiClient.getAllRestaurant();
      return userRes;
    }

    return const Text('data');
    //   return FutureBuilder<RestaurantResult>(
    //     future: search(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return ListView.builder(
    //             scrollDirection: Axis.vertical,
    //             shrinkWrap: true,
    //             primary: false,
    //             padding: const EdgeInsets.all(10),
    //             itemCount: snapshot.data!.features.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               var catalog = snapshot.data?.features[index].attributes;

    //               return Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   InkWell(
    //                     onTap: () {
    //                       Navigator.pushNamed(context, DetailCatalog.routeName,
    //                           arguments: catalog);
    //                     },
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                           boxShadow: [
    //                             BoxShadow(
    //                               color: Colors.grey.withOpacity(0.5),
    //                               spreadRadius: 5,
    //                               blurRadius: 7,
    //                               offset: const Offset(
    //                                   0, 3), // changes position of shadow
    //                             ),
    //                           ],
    //                           color: Colors.white,
    //                           borderRadius: BorderRadius.circular(8)),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(16.0),
    //                         child: Image.asset(
    //                           "assets/images/thumbs.png",
    //                           width: 120,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     padding: const EdgeInsets.all(16),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           catalog!.solutionN,
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: const TextStyle(
    //                               color: Colors.black,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                         Container(
    //                           margin: const EdgeInsets.only(top: 8),
    //                           child: Row(
    //                             children: [
    //                               Text(catalog.sectorTea),
    //                               Container(
    //                                 margin: const EdgeInsets.only(left: 8),
    //                                 child: Text(
    //                                   catalog.developmen.toString(),
    //                                   style: const TextStyle(
    //                                       color: Colors.black,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Container(
    //                           margin: const EdgeInsets.only(top: 16),
    //                           child: Row(
    //                             children: [
    //                               const Icon(Icons.fingerprint),
    //                               Container(
    //                                 margin: const EdgeInsets.only(left: 8),
    //                                 child: Text(
    //                                   catalog.solutionI,
    //                                   style: const TextStyle(
    //                                       color: Colors.black,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         Container(
    //                           decoration: BoxDecoration(
    //                               // color: kPrimaryColor,
    //                               borderRadius: BorderRadius.circular(32)),
    //                           margin: const EdgeInsets.only(top: 8),
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 const Icon(
    //                                   Icons.bookmark_add,
    //                                   color: Colors.white,
    //                                 ),
    //                                 Container(
    //                                   margin: const EdgeInsets.only(left: 4),
    //                                   child: const Text(
    //                                     "Favorite",
    //                                     style: TextStyle(
    //                                         fontSize: 10, color: Colors.white),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               );
    //             });
    //       } else {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //     },
    //   );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Column();
  }
}
