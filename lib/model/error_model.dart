class ErrorHandler {
  String? cod;
  String? message;

  ErrorHandler({this.cod, this.message});

  ErrorHandler.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    return data;
  }
}