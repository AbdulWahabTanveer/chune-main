import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../models/chune.dart';
import '../../../repositories/home_page_repo.dart';
import '../../../repositories/profile_repository.dart';

part 'home_post_event.dart';

part 'home_post_state.dart';

class HomePostBloc extends Bloc<HomePostEvent, HomePostState> {
  final profileRepo = GetIt.I.get<ProfileRepository>();
  final repo = GetIt.I.get<HomePageRepository>();

  HomePostBloc() : super(HomePostInitial()) {
    on<LoadHomePost>(_onLoadHomePost);
    on<LikeHomePost>(_onLikeHomePost);
    on<UndoLikeEvent>(
      (event, emit) => emit(
        HomePostLoaded(
          event.post.copyWith(
            isLiked: !event.post.isLiked,
            likeCount: event.post.isLiked
                ? event.post.likeCount - 1
                : event.post.likeCount + 1,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onLoadHomePost(
      LoadHomePost event, Emitter<HomePostState> emit) async {
    final card = event.post.copyWith(
        isLiked: profileRepo
            .getMyCachedProfile()
            .likedChunes
            .contains(event.post.id));
    emit(HomePostLoaded(card));
  }

  FutureOr<void> _onLikeHomePost(
      LikeHomePost event, Emitter<HomePostState> emit) async {
    if (state is HomePostLoaded) {
      final cast = state as HomePostLoaded;
      var likesCount = cast.post.likeCount ?? 0;
      if (cast.post.isLiked) {
        repo.unLikeChune(cast.post).catchError((e) {
          add(
            UndoLikeEvent(cast.post),
          );
        });
        likesCount--;
      } else {
        repo.likeChune(cast.post).catchError((e) {
          print("ERROR>>>>>>>>>>>>>>$e");
          add(UndoLikeEvent(cast.post));
        });
        likesCount++;
      }

      var likeStatus = !cast.post.isLiked;
      profileRepo.updateLikes(cast.post.id,likeStatus);
      emit(
        HomePostLoaded(
          cast.post
              .copyWith(isLiked: likeStatus, likeCount: likesCount),
        ),
      );
    }
  }
}
