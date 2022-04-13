import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/SocialLayoutCubit.dart';
import 'package:socialapp/States/SocialLayoutState.dart';
import 'package:socialapp/models/ChatModel.dart';

import 'UseModel.dart';
var massege= TextEditingController();
ChatModel chatModel =ChatModel();
class MessegesScreen extends StatelessWidget {
  UserModel? _userModel;

  MessegesScreen(this._userModel);

  @override
  Widget build(BuildContext context) {
    return Builder(
      // عايز ابنى حاجة قبل ما الكومسيومر يبدأ

      builder: (context) {
        SocialLayOutCubit.get(context).getMassages(recieverId: _userModel!.userId);
        return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
        listener:(context , state){} ,
          builder: (context , state){
          List chats = SocialLayOutCubit.get(context).masseges;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 0,
              backgroundColor:Theme.of(context).scaffoldBackgroundColor,
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${_userModel!.image}'),
                    radius: 25,
                  ),
                  const SizedBox(width: 10,),
                  Text('${_userModel!.name}')
                ],),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
               Expanded(
                 child: ListView.builder(
                   itemCount: chats.length,
                     itemBuilder: (context, index) {
                   if(_userModel!.userId== chats[index].reciverId)
                     return buildMyMassage(chats[index]);



               return   buildMassegs(chats[index]);
                 }),
               ),
                const Spacer(),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(

                      border: Border.all(
                          color: Colors.grey,width: 1
                      ),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(children:[Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: massege,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "type your massege here",
                          hintStyle: const TextStyle(fontSize: 15)
                      ),
                    ),
                  )),IconButton(onPressed: (){
                    SocialLayOutCubit.get(context).sendMassege(
                        datetime: DateTime.now().toString(),
                        msaage: massege.text,
                        reciverId: _userModel!.userId,


                    );
                    massege.clear();
                  }, icon: const Icon(Icons.send), color: Colors.blue,)] ,),),

              ],),
            ),

          );
          },
        );
      }
    );
  }
}
buildMassegs(ChatModel massege)=> BubbleSpecialThree(
  text: '${massege.message}',
  color: Color(0xFFE8E8EE),
  tail: true,
  isSender: false,
  textStyle: TextStyle(
      color: Colors.black,
      fontSize: 16
  ),);
buildMyMassage(ChatModel massege)=>  BubbleSpecialThree(
  text: '${massege.message}',
  color: const Color(0xFF1B97F3),
  tail: true,
  isSender: true,
  textStyle: TextStyle(
      color: Colors.white,
      fontSize: 16
  ),);