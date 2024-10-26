

class RestaurantsModel {
  final String? id;
  final String? alias;
  final String? name;
  final String? imageUrl;
  final bool? isClosed;
  final String? url;
  final int? reviewCount;
  final List<Category>? categories;
  final double? rating;
  final Coordinates? coordinates;
  final List<dynamic>? transactions;
  final String? price;
  final Location? location;
  final String? phone;
  final String? displayPhone;
  final double? distance;
  final List<BusinessHour>? businessHours;
  final Attributes? attributes;

  RestaurantsModel({
    this.id,
    this.alias,
    this.name,
    this.imageUrl,
    this.isClosed,
    this.url,
    this.reviewCount,
    this.categories,
    this.rating,
    this.coordinates,
    this.transactions,
    this.price,
    this.location,
    this.phone,
    this.displayPhone,
    this.distance,
    this.businessHours,
    this.attributes,
  });

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) => RestaurantsModel(
    id: json["id"],
    alias: json["alias"],
    name: json["name"],
    imageUrl: json["image_url"],
    isClosed: json["is_closed"],
    url: json["url"],
    reviewCount: json["review_count"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    rating: json["rating"]?.toDouble(),
    coordinates: json["coordinates"] == null ? null : Coordinates.fromJson(json["coordinates"]),
    transactions: json["transactions"] == null ? [] : List<dynamic>.from(json["transactions"]!.map((x) => x)),
    price: json["price"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    phone: json["phone"],
    displayPhone: json["display_phone"],
    distance: json["distance"]?.toDouble(),
    businessHours: json["business_hours"] == null ? [] : List<BusinessHour>.from(json["business_hours"]!.map((x) => BusinessHour.fromJson(x))),
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "alias": alias,
    "name": name,
    "image_url": imageUrl,
    "is_closed": isClosed,
    "url": url,
    "review_count": reviewCount,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "rating": rating,
    "coordinates": coordinates?.toJson(),
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x)),
    "price": price,
    "location": location?.toJson(),
    "phone": phone,
    "display_phone": displayPhone,
    "distance": distance,
    "business_hours": businessHours == null ? [] : List<dynamic>.from(businessHours!.map((x) => x.toJson())),
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  final dynamic businessUrl;
  final dynamic businessTempClosed;
  final dynamic menuUrl;
  final dynamic open24Hours;
  final dynamic waitlistReservation;
  final dynamic hotAndNew;

  Attributes({
    this.businessUrl,
    this.businessTempClosed,
    this.menuUrl,
    this.open24Hours,
    this.waitlistReservation,
    this.hotAndNew,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    businessUrl: json["business_url"],
    businessTempClosed: json["business_temp_closed"],
    menuUrl: json["menu_url"],
    open24Hours: json["open24_hours"],
    waitlistReservation: json["waitlist_reservation"],
    hotAndNew: json["hot_and_new"],
  );

  Map<String, dynamic> toJson() => {
    "business_url": businessUrl,
    "business_temp_closed": businessTempClosed,
    "menu_url": menuUrl,
    "open24_hours": open24Hours,
    "waitlist_reservation": waitlistReservation,
    "hot_and_new": hotAndNew,
  };
}

class BusinessHour {
  final List<Open>? open;
  final String? hoursType;
  final bool? isOpenNow;

  BusinessHour({
    this.open,
    this.hoursType,
    this.isOpenNow,
  });

  factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
    open: json["open"] == null ? [] : List<Open>.from(json["open"]!.map((x) => Open.fromJson(x))),
    hoursType: json["hours_type"],
    isOpenNow: json["is_open_now"],
  );

  Map<String, dynamic> toJson() => {
    "open": open == null ? [] : List<dynamic>.from(open!.map((x) => x.toJson())),
    "hours_type": hoursType,
    "is_open_now": isOpenNow,
  };
}

class Open {
  final bool? isOvernight;
  final String? start;
  final String? end;
  final int? day;

  Open({
    this.isOvernight,
    this.start,
    this.end,
    this.day,
  });

  factory Open.fromJson(Map<String, dynamic> json) => Open(
    isOvernight: json["is_overnight"],
    start: json["start"],
    end: json["end"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "is_overnight": isOvernight,
    "start": start,
    "end": end,
    "day": day,
  };
}

class Category {
  final String? alias;
  final String? title;

  Category({
    this.alias,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    alias: json["alias"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "alias": alias,
    "title": title,
  };
}

class Coordinates {
  final double? latitude;
  final double? longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Location {
  final String? address1;
  final String? address2;
  final String? address3;
  final String? city;
  final String? zipCode;
  final String? country;
  final String? state;
  final List<String>? displayAddress;

  Location({
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.zipCode,
    this.country,
    this.state,
    this.displayAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    address1: json["address1"],
    address2: json["address2"],
    address3: json["address3"],
    city: json["city"],
    zipCode: json["zip_code"],
    country: json["country"],
    state: json["state"],
    displayAddress: json["display_address"] == null ? [] : List<String>.from(json["display_address"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "address1": address1,
    "address2": address2,
    "address3": address3,
    "city": city,
    "zip_code": zipCode,
    "country": country,
    "state": state,
    "display_address": displayAddress == null ? [] : List<dynamic>.from(displayAddress!.map((x) => x)),
  };
}
