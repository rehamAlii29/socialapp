import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:socialapp/Screens/Post.dart';
import 'package:socialapp/SocialLayoutCubit.dart';
import 'package:socialapp/States/SocialLayoutState.dart';

class SocialLayOut extends StatefulWidget {
  // const SocialLayOut({Key? key}) : super(key: key);

  @override
  State<SocialLayOut> createState() => _SocialLayOutState();
}

SocialLayOutCubit? _cubit;

class _SocialLayOutState extends State<SocialLayOut> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
        listener: (context, State) {
      if (State is AddNewPoststate) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => Post())));
      }
    }, builder: (context, State) {
      var userdata = SocialLayOutCubit.get(context).userdata;
      _cubit = BlocProvider.of<SocialLayOutCubit>(context);
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications)),
            ],
            title: Text(
              _cubit!.titles[_cubit!.currentIndex],
            ),
          ),
          body: _cubit!.Screens[_cubit!.currentIndex],
          bottomNavigationBar: BottomNavyBar(
            items: [
              BottomNavyBarItem(
                icon: const Icon(MdiIcons.home),
                title: const Text('Home'),
                activeColor: Colors.blue,
              ),
              BottomNavyBarItem(
                icon: const Icon(MdiIcons.chat),
                title: const Text('Chats'),
                activeColor: Colors.blue,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.post_add),
                title: const Text('Post'),
                activeColor: Colors.blue,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.people),
                title: const Text('Users'),
                activeColor: Colors.blue,
              ),
              BottomNavyBarItem(
                icon: const Icon(MdiIcons.accountEdit),
                title: const Text('Profile'),
                activeColor: Colors.blue,
              ),
            ],
            selectedIndex: _cubit!.currentIndex,
            onItemSelected: (index) {
              _cubit!.changBottomNavBar(index);
            },
          ));
    });
  }
}
