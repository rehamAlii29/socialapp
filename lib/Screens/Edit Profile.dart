import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/SocialLayoutCubit.dart';
import 'package:socialapp/States/SocialLayoutState.dart';

TextEditingController Name = TextEditingController();
TextEditingController bio = TextEditingController();
TextEditingController phone = TextEditingController();
var formKey = GlobalKey<FormState>();

class EditProfile extends StatelessWidget {
  SocialLayOutCubit? _cubit;
  final Name = TextEditingController();
  final bio = TextEditingController();
  final phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          _cubit = SocialLayOutCubit.get(context);
          var model = SocialLayOutCubit.get(context).userdata;
          var profileimage = SocialLayOutCubit.get(context).profileImageFile;
          var coverimage = SocialLayOutCubit.get(context).coverimageFile;
          Name.text = model!.name!;
          bio.text = model.bio!;
          phone.text = model.phone!;

          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: IconButton(
                iconSize: 40,
                icon: const Icon(Icons.arrow_left_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Edit Profile",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // formKey.currentState!.validate();
                    //
                    //  _cubit!.uploadProfilePhototofirebase();
                    SocialLayOutCubit.get(context).update(
                      updatename: Name.text,
                      updatebio: bio.text,
                      updatephone: phone.text,
                    );
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(fontFamily: "Roboto"),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is updateuserloading)
                      const LinearProgressIndicator(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .2,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .16,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: coverimage == null
                                            ? NetworkImage(model.cover!)
                                            : FileImage(coverimage)
                                                as ImageProvider,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 10, top: 10),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 15,
                                      child: CircleAvatar(
                                        child: IconButton(
                                            onPressed: () {
                                              _cubit!.getCoverimage();
                                            },
                                            icon: const Icon(
                                              Icons.photo_camera,
                                              size: 15,
                                            )),
                                      )),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 45,
                                child: CircleAvatar(
                                  backgroundImage: profileimage == null
                                      ? NetworkImage(model.image!)
                                      : FileImage(profileimage)
                                          as ImageProvider,
                                  radius: 40,
                                ),
                              ),
                              CircleAvatar(
                                  radius: 15,
                                  child: Align(
                                    alignment: AlignmentDirectional.center,
                                    child: CircleAvatar(
                                      child: IconButton(
                                        onPressed: () {
                                          _cubit!.getProfileImage();
                                        },
                                        icon: const Icon(
                                          Icons.add_a_photo,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),

                    if (SocialLayOutCubit.get(context).profile_image != null ||
                        SocialLayOutCubit.get(context).coverimage != null)
                      Row(
                        children: [
                          if (SocialLayOutCubit.get(context).profile_image !=
                              null)
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      SocialLayOutCubit.get(context)
                                          .uploadProfilePhototofirebase(
                                        updatename: Name.text,
                                        updatephone: phone.text,
                                        updatebio: bio.text,
                                      );
                                      Navigator.pop(context);
                                      profileimage = null;
                                    },
                                    child: const Text("Upload profile "))),
                          const SizedBox(
                            width: 5,
                          ),
                          if (SocialLayOutCubit.get(context).coverimage != null)
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      SocialLayOutCubit.get(context)
                                          .uploadcoverPhototofirebase(
                                              updatename: Name.text,
                                              updatephone: phone.text,
                                              updatebio: bio.text);
                                    },
                                    child: const Text("Upload Cover "))),
                        ],
                      ),

                    // Text feilds for name and bio
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 25, 10, 25),
                              child: TextFormField(
                                controller: Name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Name Must not be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Name"),
                                  prefixIcon: Icon(Icons.people),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                              child: TextFormField(
                                controller: bio,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Name Must not be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Bio"),
                                  prefixIcon: Icon(Icons.info_outline),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                              child: TextFormField(
                                controller: phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "phine Must not be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("phone"),
                                  prefixIcon: Icon(Icons.call),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
