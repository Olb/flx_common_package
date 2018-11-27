/// A list of coupons
///
/// `coupons` List<dynamic> a list of coupons
class Coupons {
  Coupons(this.coupons);

  final List<dynamic> coupons;

  Coupons.fromJson(Map<String, dynamic> json)
      : coupons = json['coupons'];
}

/// Coupon
///
/// `ar_name` String
/// `ar_url` String
class Coupon {
  Coupon(this.name, this.url);

  final String name;
  final String url;

  Coupon.fromJson(Map<String, dynamic> json)
      : name = json['ar_name'],
        url = json['ar_url'];
}