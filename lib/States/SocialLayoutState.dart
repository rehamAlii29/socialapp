abstract class SocialLayOutStates {}

class SocialLayoutinitialState extends SocialLayOutStates {}

class socialLayOutLoading extends SocialLayOutStates {}

class socialLayOutSuccess extends SocialLayOutStates {}

class socialLayOuterror extends SocialLayOutStates {
  final String? error;
  socialLayOuterror(this.error);
}

class changeNavigationbarstate extends SocialLayOutStates {}

class AddNewPoststate extends SocialLayOutStates {}

class PickProfilePictureSuccess extends SocialLayOutStates {}

class PickProfilePictureError extends SocialLayOutStates {
  final String? Error;
  PickProfilePictureError(this.Error);
}

class PickCoverPictureSuccess extends SocialLayOutStates {}

class PickCoverPictureError extends SocialLayOutStates {
  final String? Error;
  PickCoverPictureError(this.Error);
}

class uploadprofilephotosuccess extends SocialLayOutStates {}

class uploadprofilephotoerror extends SocialLayOutStates {
  final String? error;
  uploadprofilephotoerror(this.error);
}

class uploadcoverphotosuccess extends SocialLayOutStates {}

class uploadcoverphotoerror extends SocialLayOutStates {
  final String? error;
  uploadcoverphotoerror(this.error);
}

class userupdateerror extends SocialLayOutStates {
  final String? error;
  userupdateerror(this.error);
}

class updateuserloading extends SocialLayOutStates {}

class createpostsuccess extends SocialLayOutStates {}

class createposterror extends SocialLayOutStates {
  final String? error;
  createposterror(this.error);
}

class createpostloading extends SocialLayOutStates {}

/// get el posts at new feeds
class GetPostsAtNewFeedsSuccess extends SocialLayOutStates {}

class GetPostsAtNewFeedsError extends SocialLayOutStates {
  final String onerror;
  GetPostsAtNewFeedsError(this.onerror);
}

class GetPostsAtNewFeedsLoading extends SocialLayOutStates {}

class Canclepostimagestate extends SocialLayOutStates {}

class PostLikesSuccessstate extends SocialLayOutStates {}

class PostLikesLoadingstate extends SocialLayOutStates {}

class PostLikesErrorstate extends SocialLayOutStates {
  final String? onerror;
  PostLikesErrorstate(this.onerror);
}

class PostCommentsSuccessstate extends SocialLayOutStates {}

class PostCommentsLoadingstate extends SocialLayOutStates {}

class PostCommentsErrorstate extends SocialLayOutStates {
  final String? onerror;
  PostCommentsErrorstate(this.onerror);
}

class updatepostphotosuccess extends SocialLayOutStates {}

//
class GetCommentsStateSuccess extends SocialLayOutStates {}

// chats
class SendMassegesSuccess extends SocialLayOutStates{}
class GetMassegesSuccess extends SocialLayOutStates{}
