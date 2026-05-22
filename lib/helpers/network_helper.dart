import 'package:vnote_client/constants/network_constants.dart';

class NetworkHelper {
  static final current = NetworkHelper();

  Uri? constructURL(NetworkServiceEndpoints endpoint, NetworkServiceSubEndpoints subEndpoint) {
    try {
      final accessModifier = NetworkHelper.current.getNetworkAccessModifierForEndpoint(endpoint);
      final url = '${NetworkConstants.current.baseURL}/api/${accessModifier.name}/${endpoint.name}/${subEndpoint.name}';
      return Uri.parse(url);
    } catch (e) {
      return null;
    }
  }

  bool isRequestSuccessful(int statusCode) {
    if (statusCode < 200 || statusCode >= 300) {
      return false;
    }
    return true;
  }

  NetworkServiceAccessModifiers getNetworkAccessModifierForEndpoint(NetworkServiceEndpoints endpoint) {
    switch (endpoint) {
      case NetworkServiceEndpoints.auth:
        return NetworkServiceAccessModifiers.public;
      case NetworkServiceEndpoints.business:
        return NetworkServiceAccessModifiers.private;
      case NetworkServiceEndpoints.transactions:
        return NetworkServiceAccessModifiers.private;
      case NetworkServiceEndpoints.user:
        return NetworkServiceAccessModifiers.private;
    }
  }
}
