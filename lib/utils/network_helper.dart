enum Controller { user, transaction, contact, business }

class NetworkFactory {
  static final current = NetworkFactory();
  final String hostname = "Uddeshyas-MacBook-Air.local";
  final String port = "8080";

  String getBaseUrl() {
    return "http://$hostname:$port";
  }

  String getAddedUrl(String added) {
    if (added.trim().isEmpty) {
      throw ArgumentError('No arguments passed to getAddedUrl');
    }

    final base = getBaseUrl().replaceFirst(RegExp(r'/$'), '');
    final path = added.startsWith('/') ? added : '/$added';

    return '$base$path';
  }
}
