class WeatherModel {
  List<Weather>? weather;
  WeatherTemp? weatherTemp;
  Wind? wind;
  SystemInfo? systemInfo;
  int? id;
  String? name;

  WeatherModel({this.weather, this.weatherTemp, this.id, this.name,this.wind,this.systemInfo});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    weatherTemp = json['main'] != null ? WeatherTemp.fromJson(json['main']) : null;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    systemInfo = json['sys'] != null ? SystemInfo.fromJson(json['sys']) : null;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    if (weatherTemp != null) {
      data['main'] = weatherTemp?.toJson();
    }
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class WeatherTemp {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  WeatherTemp(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity});

  WeatherTemp.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }
}

class Wind {
  String? speed;
  String? deg;
  String? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toString();
    deg = json['deg'].toString();
    gust = json['gust'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

class SystemInfo {
  String? country;

  SystemInfo({this.country});

  SystemInfo.fromJson(Map<String, dynamic> json) {
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    return data;
  }
}