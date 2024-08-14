// import 'package:bloc/bloc.dart';
// import 'package:opigno_app/data_servise/repository/graph_ql_manager.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/post_cubit/post_state.dart';

// class PostCubit extends Cubit<PostState> {
//   final GraphManager graphManager;

//   PostCubit(this.graphManager) : super(const PostState());

//   Future<void> getPosts() async {
//     // try {
//     emit(const PostState(isLoading: true));
//     final postsData = await graphManager.posts();
//     // final postData = await graphManager.post();
//     emit(PostState(postsData: postsData));
//     // } catch (e) {
//     //   emit(const PostState());
//     // }
//   }

//   Future<void> getPost(postId) async {
//     // try {
//     emit(const PostState(isLoading: true));
//     final postsData = await graphManager.posts();
//     // final postData = await graphManager.post(postId);
//     final commentData = await graphManager.getComment(postId);
//     emit(PostState(postsData: postsData, commentData: commentData));
//     // } catch (e) {
//     //   emit(const PostState());
//     // }
//   }

//   Future<void> commentPost(text, postID) async {
//     // emit(const PostState(isLoading: true));
//     final commentCreate = await graphManager.createPostComment(text, postID);
//     emit(const PostState(isLoading: true));
//     final postsData = await graphManager.posts();
//     final commentData = await graphManager.getComment(postID);
//     emit(PostState(postsData: postsData, commentData: commentData));
//   }

//   Future<void> updatePost(postID) async {
//     emit(const PostState(isLoading: true));
//     // final commentCreate = await graphManager.createPostComment(text, postID);
//     final postsData = await graphManager.posts();
//     final commentData = await graphManager.getComment(postID);
//     emit(PostState(postsData: postsData, commentData: commentData));
//   }

//   // likesGet

//   Future<void> getLike(postId) async {
//     emit(const PostState(isLoading: true));
//     final getLike = await graphManager.likesGet(postId);
//     final postsData = await graphManager.posts();
//     // final postData = await graphManager.post(postId);
//     emit(PostState(postsData: postsData, likesData: getLike));
//   }

//   Future<void> setLikeComment(int postId, int commentID) async {
//     // emit(const PostState(isLoading: true));
//     final setLike = await graphManager.likePost(commentID);
//     final postsData = await graphManager.posts();
//     final commentData = await graphManager.getComment(postId);
//     emit(PostState(
//       postsData: postsData,
//       commentData: commentData,
//     ));
//   }

//   Future<void> setLikePost(int postId) async {
//     // emit(const PostState(isLoading: false));
//     final setLike = await graphManager.likePost(postId);
//     final postsData = await graphManager.posts();
//     emit(PostState(
//       postsData: postsData,
//     ));
//   }

//   Future<void> hidePost(postId) async {
//     final hidePost = await graphManager.hidePost(postId);
//     final postsData = await graphManager.posts();
//     emit(PostState(
//       postsData: postsData,
//     ));
//   }

//   Future<void> deletePost(postId) async {
//     final deletePost = await graphManager.deletePost(postId);
//     final postsData = await graphManager.posts();
//     emit(PostState(
//       postsData: postsData,
//     ));
//   }

//   Future<void> removeConnection(autorId) async {
//     final removeConnection = await graphManager.removeConnection(autorId);
//     final postsData = await graphManager.posts();
//     emit(PostState(
//       postsData: postsData,
//     ));
//   }
// }
