class ReviewModel {
  int? id;
  final String bookTitle;
  final String author;
  final int rating; // Calificación (1-5 estrellas)
  final String description;
  final String date;

  ReviewModel({
    this.id,
    required this.bookTitle,
    required this.author,
    required this.rating,
    required this.description,
    required this.date,
  });

  // Convertir un ReviewModel a un Map para guardarlo en SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookTitle': bookTitle,
      'author': author,
      'rating': rating,
      'description': description,
      'date': date,
    };
  }

  // Crear un ReviewModel a partir de un Map obtenido de SQLite
  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] as int?,
      bookTitle: map['bookTitle'] as String,
      author: map['author'] as String,
      rating: map['rating'] as int,
      description: map['description'] as String,
      date: map['date'] as String,
    );
  }
}