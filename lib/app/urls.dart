class urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';
  static const String signUpUrl = '$_baseUrl/auth/signup';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String loginUrl = '$_baseUrl/auth/login';
  static const String homeSliderUrl = '$_baseUrl/slides';

  static String categoryList(int pageNo, int pageSize) =>
      '$_baseUrl/categories?count=$pageSize&page=$pageNo';

  static String productList(int pageNo, int pageSize, String categoryId) =>
      '$_baseUrl/products?count=$pageSize&page=$pageNo&category=$categoryId';

  static String popularProducts(int pageNo, int pageSize) =>
      '$_baseUrl/products?count=$pageSize&page=$pageNo&tag=popular';

  static String specialProducts(int pageNo, int pageSize) =>
      '$_baseUrl/products?count=$pageSize&page=$pageNo&tag=special';

  static String newProducts(int pageNo, int pageSize) =>
      '$_baseUrl/products?count=$pageSize&page=$pageNo&tag=new';

  static String productDetailsUrl(String productId) =>
      '$_baseUrl/products/id/$productId';

  static const String addToCartUrl = '$_baseUrl/cart';
  static const String cartListUrl = '$_baseUrl/cart';

  static String deleteCartItemUrl(String cartItemId) =>
      '$_baseUrl/cart/$cartItemId';

  // Wishlist URLs
  static const String wishlistUrl = '$_baseUrl/wishlist';
  static String deleteWishlistItemUrl(String wishlistItemId) =>
      '$_baseUrl/wishlist/$wishlistItemId';

  // Review URLs
  static const String createReviewUrl = '$_baseUrl/review';
  static String updateReviewUrl(String reviewId) =>
      '$_baseUrl/reviews/$reviewId';
  static String getReviewsUrl(String productId) =>
      '$_baseUrl/reviews?product=$productId';
}
