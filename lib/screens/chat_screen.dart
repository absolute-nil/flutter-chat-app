import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance
                .collection("chats/o0ys8srxX6b0WXl9GuUt/messages")
                .snapshots(),
            builder: (ctx, streamSnapShot){
              if(streamSnapShot.connectionState == ConnectionState.waiting){
                return Center(
                        child: CircularProgressIndicator(),
                      );
              }
              final documents = streamSnapShot.data.documents;

              return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (ctx, index) => Container(
                              padding: EdgeInsets.all(8),
                              child: Text(documents[index]['text']),
                            ));
            }
                ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Firestore.instance
                .collection("chats/o0ys8srxX6b0WXl9GuUt/messages").add({
                  'text': 'this was added by click'
                });
          },
          child: Icon(Icons.add),
        ));
  }
}
