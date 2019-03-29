import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';

// System
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/post_management.dart';
import 'package:life_moment/state.dart';

// Views
import 'package:life_moment/views/app_views/base_view.dart';
import 'package:life_moment/views/app_views/dashboard/dashboard.dart';
import 'package:life_moment/views/auth_views/signin_view.dart';
import 'package:life_moment/views/loading_view.dart';
import 'package:life_moment/views/error_view.dart';

// Firebase Plugins
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppStructure extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, authSnapshot){
        

        // Let the snapshot can be access gloabally
        GlobalState.authSnapshot = authSnapshot;

        // Show loading screen
        if (authSnapshot.connectionState == ConnectionState.waiting){
          return LoadingView();
        }

        if (authSnapshot.hasData){

          // Reference of the firebase user
          //GlobalState.firebaseUser = authSnapshot.data;

          // User Profile Stream:
          // This read the 'users' document in Firestore
          return StreamBuilder( 

            stream: Firestore.instance.collection('users').where('uid', isEqualTo: authSnapshot.data.uid).snapshots(),
            builder: (BuildContext context, userProfileSnapshot){

              // Let the snapshot can be access gloabally
              GlobalState.userProfileSnapshot = userProfileSnapshot; 
              
              if (userProfileSnapshot.hasError){
                return ErrorView(errorMessage: 'User Data Model Error',);
              }

              if (userProfileSnapshot.hasData){

                if (userProfileSnapshot.data.documents.length == 0){
                  return SignInView();
                }

                return StreamBuilder(
                  stream: Firestore.instance.collection('users').document(userProfileSnapshot.data.documents[0].documentID).collection('notifications').snapshots(),
                  builder: (BuildContext context, notificationSnapshot){

                    GlobalState.notificationSnapshot = notificationSnapshot;

                    if (notificationSnapshot.hasError){
                      return ErrorView(errorMessage: 'User Model Error',);
                    }

                    return Dashboard();
                  },
                );
                
              }
              return LoadingView();
            }
          );
        }
        return SignInView();
      }
    );
  }
}

// class AppContext extends InheritedWidget {

//   AppContext({this.authSnapshot, this.userProfileSnapshot, Widget child})
//   : assert(child != null, '[AppContext] child cannot be null')
//   , super(child: child);

//   // From stream
//   final authSnapshot;
//   final userProfileSnapshot;

//   UserProfile get userProfile {
//     Map<String, dynamic> dataMap = userProfileSnapshot.data.documents[0].data;
//     dataMap['documentID'] = userProfileSnapshot.data.documents[0].documentID;
//     return UserProfile.createFormDataMap(dataMap: dataMap);
//   }


//   final Map<String, NewsFeedData> _tempNewsFeedDataMap = {};
//   final Map<String, NewsFeedData> _newsFeedDataMap = {};
//   final Map<String, NewsFeedData> _userPostDataMap = {}; 


//   bool isNewsFeedDataEmpty(){

//     return _newsFeedDataMap.isEmpty && _tempNewsFeedDataMap.isEmpty;
//   }

//   Future<OperationResponse> refreshNewsFeedDataMap() async{

//     OperationResponse response = await PostManagement.loadNewsFeed(userProfile);
//     List<dynamic> postData = response.data;

//     postData.forEach((data) {
      
//       NewsFeedData instanceNewsFeedData = NewsFeedData.createFromDataMap(dataMap: data);
//       updateNewsFeedDataList(instanceNewsFeedData);
//     });
//     return response;
//   } 


//   void updateNewsFeedDataList(NewsFeedData data){

//     String postID = data.postID;
//     if (_tempNewsFeedDataMap.containsKey(postID)){
//       _tempNewsFeedDataMap.remove(postID);
//     }
//     _newsFeedDataMap[data.postID] = data;  
//   }

//   void appendNewsFeedDataToTempList(NewsFeedData data){

//     String postID = data.postID;
//     _tempNewsFeedDataMap[postID] = data;
//   }

//   void updateUserPostDataList(NewsFeedData data){
//     String postID = data.postID;
//     _userPostDataMap[postID] = data;
//   }

//   List<NewsFeedData> get newsFeedDataList {
//     return _newsFeedDataMap.values.toList();
//   }

//   List<NewsFeedData> get newsFeedDataTempList {
//     return _tempNewsFeedDataMap.values.toList();
//   }

//   List<NewsFeedData> get userPostDataList {
//     return _userPostDataMap.values.toList();
//   }


//   static AppContext of(BuildContext context){
//     return context.inheritFromWidgetOfExactType(AppContext) as AppContext;
//   }

//   @override
//   bool updateShouldNotify(AppContext oldWidget) {

//     debugPrint('[AppContext] Updated');
//     return false;
//   }
// }