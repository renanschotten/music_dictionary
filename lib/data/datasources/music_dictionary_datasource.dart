import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:music_dictionary/data/models/app_content_model.dart';
import 'package:music_dictionary/shared/constants/firebase_keys.dart';
import 'package:music_dictionary/shared/core/failure.dart';

abstract class MusicDictionaryDatasource {
  Future<Either<Failure, List<AppContentModel>>> fetchHomePage();
}

class MockMusicDictionaryDatasource implements MusicDictionaryDatasource {
  @override
  Future<Either<Failure, List<AppContentModel>>> fetchHomePage() async {
    await Future.delayed(Duration(seconds: 2));
    return Right([
      AppContentModel(name: 'Acordes', path: '/chords'),
      AppContentModel(name: 'Escalas', path: '/scales')
    ]);
  }
}

class FirestoreMusicDictionaryDatasource implements MusicDictionaryDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, List<AppContentModel>>> fetchHomePage() async {
    try {
      final response = await firestore
          .collection(FirebaseKeys.homePageCollection)
          .doc(FirebaseKeys.homePageContents)
          .get();
      final array = response.data()?['contents'];
      final homePageData =
          array.map((e) => AppContentModel.fromMap(e)).toList();
      return Right(homePageData);
    } on FirebaseException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message ?? 'Erro de Conexao',
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }
}
