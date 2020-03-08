import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:manipuling_api/src/pages/home/home_repository.dart';
import 'package:manipuling_api/src/shared/models/post_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CreateBloc extends BlocBase {
  final HomeRepository repo;

  CreateBloc(this.repo){
    responseOut = post.switchMap(observablePost);
  }

  String title;
  String body;

  var post = BehaviorSubject<PostModel>();

  PostModel get postValue => post.value;
  Observable<int> responseOut;
  Sink<PostModel> get postIn => post.sink;

  Stream<int> observablePost(PostModel data) async* {
    yield 0;
    try{
    var response = await repo.createPost(data.toJson());
    yield response;
    }catch(e){
      throw e;
    }
  }

  @override
  void dispose() {
    post.close();
    super.dispose();
  }
}
