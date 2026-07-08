class RechargeOffer {
  bool? status;
  Lookup? lookup;
  Product? product;
  Offers? offers;

  RechargeOffer({this.status, this.lookup, this.product, this.offers});

  RechargeOffer.fromJson(Map<String, dynamic> json) {
    status = json['status'] is bool
        ? json['status']
        : (json['status']?.toString().toLowerCase() == 'true');
    lookup =
        json['lookup'] != null ? new Lookup.fromJson(json['lookup']) : null;
    product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
    offers =
        json['offers'] != null ? new Offers.fromJson(json['offers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.lookup != null) {
      data['lookup'] = this.lookup!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.offers != null) {
      data['offers'] = this.offers!.toJson();
    }
    return data;
  }
}

class Lookup {
  String? tel;
  Records? records;
  String? status;

  Lookup({this.tel, this.records, this.status});

  Lookup.fromJson(Map<String, dynamic> json) {
    // Convert defensively: API may send tel as a number
    tel = json['tel']?.toString();
    records = json['records'] != null
        ? new Records.fromJson(json['records'])
        : null;
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tel'] = this.tel;
    if (this.records != null) {
      data['records'] = this.records!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Records {
  String? status;
  String? operator;
  String? circle;
  String? comcircle;
  int? circlecode;

  Records(
      {this.status,
      this.operator,
      this.circle,
      this.comcircle,
      this.circlecode});

  Records.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    operator = json['operator']?.toString();
    circle = json['circle']?.toString();
    // comcircle sometimes comes back as a number from these recharge APIs
    comcircle = json['comcircle']?.toString();
    // circlecode: be safe in case it arrives as a String too
    circlecode = json['circlecode'] is int
        ? json['circlecode']
        : int.tryParse(json['circlecode']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['operator'] = this.operator;
    data['circle'] = this.circle;
    data['comcircle'] = this.comcircle;
    data['circlecode'] = this.circlecode;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;

  Product({
    this.id,
    this.name,
    this.description,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '');
    name = json['name']?.toString();
    description = json['description']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class Offers {
  String? tel;
  String? operator;
  List<OfferRecords>? records;

  Offers({
    this.tel,
    this.operator,
    this.records,
  });

  Offers.fromJson(Map<String, dynamic> json) {
    tel = json['tel']?.toString();
    operator = json['operator']?.toString();

    if (json['records'] != null) {
      records = <OfferRecords>[];
      json['records'].forEach((v) {
        records!.add(OfferRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['tel'] = tel;
    data['operator'] = operator;

    if (records != null) {
      data['records'] = records!.map((e) => e.toJson()).toList();
    }

    return data;
  }
}

class OfferRecords {
  // `rs` (the recharge amount) is very commonly sent as a JSON number
  // (e.g. "rs": 199) rather than a string — this was the likely crash source.
  String? rs;
  String? desc;

  OfferRecords({this.rs, this.desc});

  OfferRecords.fromJson(Map<String, dynamic> json) {
    rs = json['rs']?.toString();
    desc = json['desc']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rs'] = this.rs;
    data['desc'] = this.desc;
    return data;
  }
}