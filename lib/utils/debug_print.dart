
import 'package:flutter/cupertino.dart';
import 'package:vnote_client/utils/env_validator_helper.dart';

class DebugPrint {
    static final current = DebugPrint();
    bool get _isDev {
        return EnvironmentValidator.current.getValidEnvKey(
            EnvironmentValues.environment.value,
        ) == EnvironmentValues.devEnvironment.value;
    }
    void log(List<dynamic> messages) {
        if (_isDev) {
            debugPrint(messages.join(" "));
        }
    }

    void error(List<dynamic> messages) {
        if (_isDev) {
            debugPrint("❌ ERROR: ${messages.join(" ")}");
        }
    }

    void success(List<dynamic> messages) {
        if (_isDev) {
            debugPrint("✅ SUCCESS: ${messages.join(" ")}");
        }
    }

    void warning(List<dynamic> messages) {
        if (_isDev) {
            debugPrint("⚠️ WARNING: ${messages.join(" ")}");
        }
    }
}
