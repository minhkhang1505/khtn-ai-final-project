class DataSourceRequest {
  List<Datasource> datasources;

  DataSourceRequest({required this.datasources});

  DataSourceRequest copyWith({List<Datasource>? datasources}) =>
      DataSourceRequest(datasources: datasources ?? this.datasources);

  factory DataSourceRequest.fromJson(Map<String, dynamic> json) {
    return DataSourceRequest(
      datasources: json['datasources'] != null
          ? (json['datasources'] as List)
                .map((i) => Datasource.fromJson(i))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'datasources': datasources.map((v) => v.toJson()).toList()};
  }
}

class Datasource {
  Credentials? credentials;
  String? name;
  String? type;

  Datasource({this.credentials, this.name, this.type});

  Datasource copyWith({Credentials? credentials, String? name, String? type}) =>
      Datasource(
        credentials: credentials ?? this.credentials,
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory Datasource.fromJson(Map<String, dynamic> json) {
    return Datasource(
      credentials: json['credentials'] != null
          ? Credentials.fromJson(json['credentials'])
          : null,
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (credentials != null) 'credentials': credentials!.toJson(),
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    };
  }
}

class Credentials {
  String? email;
  String? file;
  Map<String, dynamic>? info;
  String? password;
  String? token;
  String? type;
  String? url;
  String? username;

  Credentials({
    this.email,
    this.file,
    this.info,
    this.password,
    this.token,
    this.type,
    this.url,
    this.username,
  });

  Credentials copyWith({
    String? email,
    String? file,
    Map<String, dynamic>? info,
    String? password,
    String? token,
    String? type,
    String? url,
    String? username,
  }) => Credentials(
    email: email ?? this.email,
    file: file ?? this.file,
    info: info ?? this.info,
    password: password ?? this.password,
    token: token ?? this.token,
    type: type ?? this.type,
    url: url ?? this.url,
    username: username ?? this.username,
  );

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      email: json['email'],
      file: json['file'],
      info: json['info'],
      password: json['password'],
      token: json['token'],
      type: json['type'],
      url: json['url'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (file != null) 'file': file,
      if (info != null) 'info': info,
      if (password != null) 'password': password,
      if (token != null) 'token': token,
      if (type != null) 'type': type,
      if (url != null) 'url': url,
      if (username != null) 'username': username,
    };
  }
}
