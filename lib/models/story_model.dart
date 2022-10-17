class Story {
  String id;
  String imageUrl;
  bool isViewed;
  DateTime uploadDate;

  Story({
    required this.id,
    required this.imageUrl,
    required this.isViewed,
    required this.uploadDate,
  });

  static List<Story> listStories = [
    Story(
        id: "1",
        imageUrl:
            'https://images.unsplash.com/photo-1588925762549-c414056c4d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW90b2Jpa2V8ZW58MHx8MHx8&w=1000&q=80',
        isViewed: false,
        uploadDate: DateTime(2022)),
    Story(
        id: "1",
        imageUrl:
            'https://images.unsplash.com/photo-1588925762549-c414056c4d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW90b2Jpa2V8ZW58MHx8MHx8&w=1000&q=80',
        isViewed: false,
        uploadDate: DateTime(2022)),
    Story(
        id: "1",
        imageUrl:
            'https://images.unsplash.com/photo-1588925762549-c414056c4d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW90b2Jpa2V8ZW58MHx8MHx8&w=1000&q=80',
        isViewed: false,
        uploadDate: DateTime(2022)),
    Story(
        id: "1",
        imageUrl:
            'https://images.unsplash.com/photo-1588925762549-c414056c4d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW90b2Jpa2V8ZW58MHx8MHx8&w=1000&q=80',
        isViewed: false,
        uploadDate: DateTime(2022)),
    Story(
        id: "1",
        imageUrl:
            'https://images.unsplash.com/photo-1588925762549-c414056c4d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW90b2Jpa2V8ZW58MHx8MHx8&w=1000&q=80',
        isViewed: false,
        uploadDate: DateTime(2022))
  ];
}
