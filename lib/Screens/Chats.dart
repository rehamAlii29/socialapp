

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/States/SocialLayoutState.dart';
import 'package:socialapp/UseModel.dart';

import '../MassegesScreen.dart';
import '../SocialLayoutCubit.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
     listener: (context, state){},
      builder: (context, state){
       SocialLayOutCubit.get(context).getAllUsers();
       return   Scaffold(

         body: SingleChildScrollView(child:

         StreamBuilder<QuerySnapshot>(
           stream: SocialLayOutCubit.get(context).usercollection.snapshots(),
           builder: (context, snapshot) {
             return ListView.separated(
               shrinkWrap: true,
               physics: BouncingScrollPhysics(),
               itemCount: SocialLayOutCubit.get(context).allusers.length,
               itemBuilder: (context , index){
                 return buildUserItem(context, SocialLayOutCubit.get(context).allusers[index]);
               },
               separatorBuilder: (context,index){
                 return Divider(
                   thickness: .5,

                 );
               },
             );
           }
         )
           ,) ,
       );
      },
    );
  }
}
buildUserItem(BuildContext context , UserModel allusers, ){
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MessegesScreen(allusers)));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                "${allusers.image}"),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Row(
            children: [
            Row(
            children: [
            Text(
            "${allusers.name}",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(
              height: 1.3,
            ),
          ),])
        ],)])
          )]),
    ),
  );
}
