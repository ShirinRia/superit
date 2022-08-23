import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:superit/screens/profile_screen.dart';

import '../utils/colors.dart';
import '../utils/global_variable.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration:
                const InputDecoration(labelText: 'Search for a user...'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              print(_);
            },
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username'.toLowerCase(),
                    isEqualTo: searchController.text.toLowerCase(),
                  )
                  .get(),
              builder: (context, snapshot) {
                // if (!snapshot.hasData) {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }
                if (snapshot.hasError) {
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where(
                      'description',
                      //isEqualTo: "Mehedi 2022",
                      isEqualTo: searchController.text,
                    )
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      // return Container();
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 3,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) => Image.network(
                          (snapshot.data! as dynamic).docs[index]['postUrl'],
                          fit: BoxFit.cover,
                        ),
                        staggeredTileBuilder: (index) => MediaQuery.of(context)
                            .size
                            .width >
                            webScreenSize
                            ? StaggeredTile.count(
                            (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                            : StaggeredTile.count(
                            (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      );
                    },
                  );
                }
                else {
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () =>
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(
                                      uid: (snapshot.data! as dynamic)
                                          .docs[index]
                                          .data()['uid'],
                                    ),
                              ),
                            ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic)
                                  .docs[index]
                                  .data()['photoUrl'],
                            ),
                            radius: 16,
                          ),
                          title: Text(
                            (snapshot.data! as dynamic)
                                .docs[index]
                                .data()['username'],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )


      : FutureBuilder(
               future: FirebaseFirestore.instance
                   .collection('posts')
                   .where(

                 //isEqualTo: "Iot",
                 'description',
                 //arrayContains:'Birthday of Sadib' ,
                // isEqualTo: 'Birthday of Sadib',

                 isGreaterThanOrEqualTo: 'Birthday'
               )
                   .get(),
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return const Center(
                     child: CircularProgressIndicator(),
                   );
                 }
              // return Container();
                 return StaggeredGridView.countBuilder(
                   crossAxisCount: 3,
                   itemCount: (snapshot.data! as dynamic).docs.length,
                   itemBuilder: (context, index) => Image.network(
                     (snapshot.data! as dynamic).docs[index]['postUrl'],
                     fit: BoxFit.cover,
                   ),
                   staggeredTileBuilder: (index) => MediaQuery.of(context)
                               .size
                               .width >
                           webScreenSize
                       ? StaggeredTile.count(
                           (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                       : StaggeredTile.count(
                           (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                   mainAxisSpacing: 8.0,
                   crossAxisSpacing: 8.0,
                 );
               },
             ),
    );
  }
}
