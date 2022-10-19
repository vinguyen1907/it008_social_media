class Story {
  String id;
  String imageUrl;
  bool isViewed;
  DateTime uploadDate;
  bool isFullScreen;

  Story({
    required this.id,
    required this.imageUrl,
    required this.isViewed,
    required this.uploadDate,
    this.isFullScreen = false,
  });

  static List<Story> listStories = [
    Story(
      id: "1",
      imageUrl:
          'https://images.unsplash.com/photo-1594058573823-d8edf1ad3380?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=462&q=80',
      isViewed: false,
      uploadDate: DateTime(2022),
      isFullScreen: true,
    ),
    Story(
      id: "1",
      imageUrl:
          'https://images.unsplash.com/photo-1588925762549-c414056c4d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW90b2Jpa2V8ZW58MHx8MHx8&w=1000&q=80',
      isViewed: false,
      uploadDate: DateTime(2022),
      isFullScreen: true,
    ),
    Story(
        id: "1",
        imageUrl:
            'https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        isViewed: false,
        uploadDate: DateTime(2022)),
    Story(
        id: "1",
        imageUrl:
            'https://images.unsplash.com/photo-1565630916779-e303be97b6f5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
        isViewed: false,
        uploadDate: DateTime(2022)),
    Story(
      id: "1",
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
      isViewed: false,
      uploadDate: DateTime(2022),
      isFullScreen: true,
    )
  ];
}
