class DataSourceRequest {
    List<Datasource> datasources;

    DataSourceRequest({
        required this.datasources,
    });

    DataSourceRequest copyWith({
        List<Datasource>? datasources,
    }) => 
        DataSourceRequest(
            datasources: datasources ?? this.datasources,
        );
}

class Datasource {
    Credentials? credentials;
    String? name;
    String? type;

    Datasource({
        this.credentials,
        this.name,
        this.type,
    });

    Datasource copyWith({
        Credentials? credentials,
        String? name,
        String? type,
    }) => 
        Datasource(
            credentials: credentials ?? this.credentials,
            name: name ?? this.name,
            type: type ?? this.type,
        );
}

class Credentials {
    String email;
    String file;
    Map<String, dynamic> info;
    String password;
    String token;
    String type;
    String url;
    String username;

    Credentials({
        required this.email,
        required this.file,
        required this.info,
        required this.password,
        required this.token,
        required this.type,
        required this.url,
        required this.username,
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
    }) => 
        Credentials(
            email: email ?? this.email,
            file: file ?? this.file,
            info: info ?? this.info,
            password: password ?? this.password,
            token: token ?? this.token,
            type: type ?? this.type,
            url: url ?? this.url,
            username: username ?? this.username,
        );
}