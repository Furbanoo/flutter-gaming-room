class RatingFormmater {
  static double formattedRating(double rating) {
    double stars = (rating / 100) * 5;
    return stars;
  }
}
