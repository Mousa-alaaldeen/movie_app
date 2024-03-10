// ignore_for_file: unnecessary_getters_setters

class TranslationsModel {
  int? _id;
  List<Translations>? _translations;

  TranslationsModel({int? id, List<Translations>? translations}) {
    if (id != null) {
      _id = id;
    }
    if (translations != null) {
      _translations = translations;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  List<Translations>? get translations => _translations;
  set translations(List<Translations>? translations) =>
      _translations = translations;

  TranslationsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    if (json['translations'] != null) {
      _translations = <Translations>[];
      json['translations'].forEach((v) {
        _translations!.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    if (_translations != null) {
      data['translations'] = _translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  String? _iso31661;
  String? _iso6391;
  String? _name;
  String? _englishName;
  Data? _data;

  Translations(
      {String? iso31661,
      String? iso6391,
      String? name,
      String? englishName,
      Data? data}) {
    if (iso31661 != null) {
      _iso31661 = iso31661;
    }
    if (iso6391 != null) {
      _iso6391 = iso6391;
    }
    if (name != null) {
      _name = name;
    }
    if (englishName != null) {
      _englishName = englishName;
    }
    if (data != null) {
      _data = data;
    }
  }

  String? get iso31661 => _iso31661;
  set iso31661(String? iso31661) => _iso31661 = iso31661;
  String? get iso6391 => _iso6391;
  set iso6391(String? iso6391) => _iso6391 = iso6391;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get englishName => _englishName;
  set englishName(String? englishName) => _englishName = englishName;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  Translations.fromJson(Map<String, dynamic> json) {
    _iso31661 = json['iso_3166_1'];
    _iso6391 = json['iso_639_1'];
    _name = json['name'];
    _englishName = json['english_name'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_3166_1'] = _iso31661;
    data['iso_639_1'] = _iso6391;
    data['name'] = _name;
    data['english_name'] = _englishName;
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _homepage;
  String? _overview;
  int? _runtime;
  String? _tagline;
  String? _title;

  Data(
      {String? homepage,
      String? overview,
      int? runtime,
      String? tagline,
      String? title}) {
    if (homepage != null) {
      _homepage = homepage;
    }
    if (overview != null) {
      _overview = overview;
    }
    if (runtime != null) {
      _runtime = runtime;
    }
    if (tagline != null) {
      _tagline = tagline;
    }
    if (title != null) {
      _title = title;
    }
  }

  String? get homepage => _homepage;
  set homepage(String? homepage) => _homepage = homepage;
  String? get overview => _overview;
  set overview(String? overview) => _overview = overview;
  int? get runtime => _runtime;
  set runtime(int? runtime) => _runtime = runtime;
  String? get tagline => _tagline;
  set tagline(String? tagline) => _tagline = tagline;
  String? get title => _title;
  set title(String? title) => _title = title;

  Data.fromJson(Map<String, dynamic> json) {
    _homepage = json['homepage'];
    _overview = json['overview'];
    _runtime = json['runtime'];
    _tagline = json['tagline'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['homepage'] = _homepage;
    data['overview'] = _overview;
    data['runtime'] = _runtime;
    data['tagline'] = _tagline;
    data['title'] = _title;
    return data;
  }
}
