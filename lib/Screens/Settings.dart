import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:socialapp/Screens/Edit%20Profile.dart';
import 'package:socialapp/SocialLayoutCubit.dart';
import 'package:socialapp/States/SocialLayoutState.dart';

class AppSettings extends StatefulWidget {
  @override
  State<AppSettings> createState() => _AppSettingsState();
}

SocialLayOutCubit? _cubit;

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // _cubit = BlocProvider.of<SocialLayOutCubit>(context);
          var model = SocialLayOutCubit.get(context).userdata;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .16,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage('${model!.cover}'))),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 45,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage('${model.image}'),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${model.name}",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${model.bio}",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Posts",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Photos",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "10k",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Fllowers",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Follwing",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: OutlineButton(
                            onPressed: () {},
                            child: const Text(
                              "Add Photo",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 40,
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                            },
                            child: const Icon(MdiIcons.imageEdit)),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
