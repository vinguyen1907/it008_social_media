class Post {
  String id;
  String userId;
  DateTime uploadTime;
  String imageUrl;
  String caption;

  Post({
    required this.id,
    required this.userId,
    required this.uploadTime,
    required this.imageUrl,
    required this.caption,
  });

  static List<Post> listPosts = [
    Post(
        id: '1',
        userId: '1',
        uploadTime: DateTime(2022),
        imageUrl:
            'https://blog.adobe.com/en/publish/2021/06/07/media_195b35fcc892daf3ce573058a9626ac720f61f0cd.png?width=750&format=png&optimize=medium',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra'),
    Post(
        id: '1',
        userId: '1',
        uploadTime: DateTime(2022),
        imageUrl:
            'https://blog.adobe.com/en/publish/2021/06/07/media_195b35fcc892daf3ce573058a9626ac720f61f0cd.png?width=750&format=png&optimize=medium',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra'),
    Post(
        id: '1',
        userId: '1',
        uploadTime: DateTime(2022),
        imageUrl:
            'https://blog.adobe.com/en/publish/2021/06/07/media_195b35fcc892daf3ce573058a9626ac720f61f0cd.png?width=750&format=png&optimize=medium',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra'),
    Post(
        id: '1',
        userId: '1',
        uploadTime: DateTime(2022),
        imageUrl:
            'https://blog.adobe.com/en/publish/2021/06/07/media_195b35fcc892daf3ce573058a9626ac720f61f0cd.png?width=750&format=png&optimize=medium',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra')
  ];
}
