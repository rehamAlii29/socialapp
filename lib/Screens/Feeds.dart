import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:socialapp/SocialLayoutCubit.dart';
import 'package:socialapp/States/SocialLayoutState.dart';
import 'package:socialapp/models/Commentmodel.dart';
import 'package:socialapp/models/PostModel.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

int? selectedindex;
SocialLayOutCubit? cubit;

var comment = TextEditingController();

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLayOutCubit()
        ..getPostsAttnewfeeds()
        ..getUserData(),
      child: BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
        listener: (context, State) {},
        builder: (context, State) {
          cubit = BlocProvider.of<SocialLayOutCubit>(context);

          return SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                      child: const Image(
                        image: NetworkImage(
                            "https://img.freepik.com/free-vector/hand-drawn-flat-people-dancing_23-2149058997.jpg?w=740"),
                        fit: BoxFit.cover,
                        width: 120,
                      ),
                    )
                  ]),
                ),
                if (SocialLayOutCubit.get(context).postAtNewwfeeds.isNotEmpty &&
                    SocialLayOutCubit.get(context).userdata != null)
                  ListView.builder(
                    // elpost el wa7ed "item elly fel list by index " 3bara asln 3n post model
                    itemBuilder: (context, index) => BuildPostItem(
                        SocialLayOutCubit.get(context).postAtNewwfeeds[index],
                        context,
                        index,
                        SocialLayOutCubit.get(context).commentslist[index]),
                    itemCount:
                        SocialLayOutCubit.get(context).postAtNewwfeeds.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget BuildPostItem(
        PostModel postModel, context, index, Commentmodel commentmodel) =>
    Card(
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      "${SocialLayOutCubit.get(context).userdata!.image}"),
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
                                  "${SocialLayOutCubit.get(context).userdata!.name}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                        height: 1.3,
                                      ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.verified_rounded,
                                  size: 15,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '${postModel.postTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.3, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_horiz)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                color: Colors.grey[300],
                width: double.infinity,
                height: 1,
              ),
            ),
            Text(
              '${postModel.postText}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Wrap(
              children: [
                Container(
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 1,
                    height: 20,
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: const Text(
                      "#Software",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 1,
                    height: 20,
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: const Text(
                      "#Flutter",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            if (postModel.postImage != "")
              Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "${postModel.postImage}",
                        ))),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            MdiIcons.heartOutline,
                            color: Colors.red,
                            size: 15,
                          ),
                          Text(
                              "${SocialLayOutCubit.get(context).likes[index]}"),
                        ],
                      ),
                    )),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print(SocialLayOutCubit.get(context)
                              .commentslist[index]
                              .commentText
                              .toString());
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return (Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                  '${commentmodel.commentText}'),
                                            )
                                          ],
                                        ));
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                          thickness: .5,
                                        );
                                      },
                                      itemCount: SocialLayOutCubit.get(context)
                                          .commentslength[index]),
                                );
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              MdiIcons.chatOutline,
                              size: 15,
                              color: Colors.amber,
                            ),
                            Text(
                                "${SocialLayOutCubit.get(context).commentslength[index]}")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                color: Colors.grey[300],
                width: double.infinity,
                height: 1,
              ),
            ),
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        "${SocialLayOutCubit.get(context).userdata!.image}"),
                  ),
                  const SizedBox(
                    width: 10,
                  ), // hena ellcomment
                  Expanded(
                    child: InkWell(
                      child: Container(
                        child: const Text("Comment here"),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      ///
                                      Expanded(
                                          child: TextFormField(
                                        controller: comment,
                                      )),
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                SocialLayOutCubit.get(context)
                                                    .writeComment(
                                                        postid: cubit!
                                                            .postid[index],
                                                        commentText:
                                                            comment.text);
                                                comment.text = "";
                                                Navigator.pop(context);
                                              },
                                              child: const Text("comment")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancle"))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialLayOutCubit.get(context).postLike(
                          SocialLayOutCubit.get(context).postid[index]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Colors.red,
                          size: 15,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text("Like")
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
