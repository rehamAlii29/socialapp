import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:socialapp/SocialLayoutCubit.dart';
import 'package:socialapp/States/SocialLayoutState.dart';

DateTime currentTime = DateTime.now();

class Post extends StatelessWidget {
  // the "dd/MM/yyyy HH:mm" format

  var postController = TextEditingController();

  var now = DateFormat.yMd().add_jm().format(currentTime);
  @override
  Widget build(BuildContext context) {
    var model = SocialLayOutCubit.get(context).userdata;
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
        listener: (context, state) {
      if (State is createpostsuccess) {
        Navigator.pop(context);
        SocialLayOutCubit.get(context).getPostsAttnewfeeds();
      }
    }, builder: (context, state) {
      var imageofpost = SocialLayOutCubit.get(context).imagepost;
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text("Add post"),
            actions: [
              TextButton(
                  onPressed: () {
                    SocialLayOutCubit.get(context).PostWithimage(
                        Posttext: postController.text,
                        Posttime: now.toString());

                    /// mafrod yb2a feh fet el post ya ema hena aw fel cubit w hastna ba2y el shar7 ymkn ykon feh
                    /*   if (SocialLayOutCubit.get(context).imagepost == null) {
                      SocialLayOutCubit.get(context).PostWithoutImage(
                          PostText: postController.text,
                          posttime: now.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Feeds()));
                    } else {
                      SocialLayOutCubit.get(context).PostWithimage(
                          Posttext: postController.text,
                          Posttime: now.toString());
                      Navigator.pop(context);
                    }*/
                  },
                  child: const Text("Post"))
            ],
          ),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${model!.image}'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        '${model.name}',
                        style: Theme.of(context).textTheme.subtitle1!,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: postController,
                decoration: const InputDecoration(
                    hintText: "Whats in your mind",
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            if (SocialLayOutCubit.get(context).imagepost != null)
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.height * .3,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(imageofpost!)))),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {
                              SocialLayOutCubit.get(context).canclePostImage();
                            },
                            icon: const Icon(Icons.close)),
                      )
                    ],
                  ),

                  /*,*/
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        SocialLayOutCubit.get(context).getpostimage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_a_photo_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Add Photo")
                        ],
                      )),
                ),
                Expanded(
                    child: TextButton(
                        onPressed: () {}, child: const Text("#tags")))
              ],
            ),
          ]));
    });
  }
}
