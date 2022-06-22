import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({required this.id, required this.title, required this.thumbnailUrl});

  final int id;
  final String title;
  final String thumbnailUrl;

  @override
  List<Object> get props => [id, title, thumbnailUrl];
}