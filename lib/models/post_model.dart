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
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=481&q=80',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra'),
    Post(
        id: '1',
        userId: '1',
        uploadTime: DateTime(2022),
        imageUrl:
            'https://images.unsplash.com/photo-1582340212186-1aa94e022dca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra'),
    Post(
        id: '1',
        userId: '1',
        uploadTime: DateTime(2022),
        imageUrl:
            'https://images.unsplash.com/photo-1527661591475-527312dd65f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=415&q=80',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra')
  ];
}
