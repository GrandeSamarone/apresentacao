class MovieModel {
  const MovieModel({
    required this.title,
     this.description,
    required this.urlImage,
   this.original_language,
     this.popularity,
     this.date,
     this.vote_average,
     this.vote_count,
  });

  final String title;
  final String? description;
  final String urlImage;
  final String? original_language;
  final double? popularity;
  final String? date;
  final double? vote_average;
  final int? vote_count;
}
