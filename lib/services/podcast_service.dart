import 'package:it008_social_media/models/podcast_model.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class PodcastService {
  static Future<List<Podcast>> getMyPodcast(String userId) async {
    final snapshot = await podcastsRef.doc(userId).collection('podcasts').get();

    return snapshot.docs.map((doc) => Podcast.fromJson(doc.data())).toList();
  }
}
