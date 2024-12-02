

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/12/24
library;

enum ApiPathsEnums {
  v1(path: '/api/v1'),
  signIn(path: '/api/v1/auth/login'),
  refreshToken(path: '/api/v1/auth/refresh-token'),
  logout(path: '/api/v1/auth/logout'),
  inbound(path: '/api/v1/inbound'),
  outgoing(path: '/api/v1/outbound'),
  count(path: '/api/v1/tally'),
  countValidate(path: '/api/v1/tally/compare'),
  relocation(path: '/api/v1/relocation'),
  clients(path: '/api/v1/customers'),
  warehouses(path: '/api/v1/warehouses'),
  getStocksBySeries(path: '/api/v1/stocks/series');

  const ApiPathsEnums({required this.path});

  final String path;

}