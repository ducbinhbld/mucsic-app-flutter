import 'package:music_app/data/source/source.dart';
import '../model/song.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();
  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    List<Song>? remoteSongs = await _remoteDataSource.loadData();

    if (remoteSongs == null) {
      List<Song>? localSongs = await _localDataSource.loadData();
      if (localSongs != null) {
        songs.addAll(localSongs);
      }
    } else {
      songs.addAll(remoteSongs);
    }

    return songs;
  }
}
