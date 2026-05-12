import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentValidator {
    static final current = EnvironmentValidator();

    String getValidEnvKey(String key) {
        final String? keyT = dotenv.env[key];
        if(keyT == null) throw Exception("Environment Variable Not Found For Key: $key");
        return keyT;
    }
}

enum EnvironmentValues {
    devEnvironment("dev"),
    prodEnvironment("prod"),
    environment("VNOTE_MOBILE_CLIENT_ENV");

    final String value;
    const EnvironmentValues(this.value);
}
