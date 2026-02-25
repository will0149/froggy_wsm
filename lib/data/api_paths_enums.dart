

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/12/24
library;

enum ApiPathsEnums {
  v1(path: 'http://0.0.0.0:8000/v1/'),
  //user authentication and enrollment
  registerUser(path: '/user/register/'),
  signIn(path: '/user/login/'),
  logout(path: '/user/logout/'),
  passwordReset(path: '/user/password/reset/'),
  passwordResetConfirm(path: '/user/password/reset/confirm'),
  refreshToken(path: '/user/token/refresh/'),
  tokenVerify(path: '/user/token/verify/'),
  inbound(path: '/api/v1/inbound'),
  outgoing(path: '/api/v1/outbound'),
  count(path: '/api/v1/tally'),
  countValidate(path: '/api/v1/tally/compare'),
  relocation(path: '/api/v1/relocation'),
  clients(path: '/api/v1/customers'),
  warehouses(path: '/api/v1/warehouses'),
  getStocksBySeries(path: '/api/v1/stocks/series'),
  getStocksByCartonId(path: '/api/v1/stocks');

  const ApiPathsEnums({required this.path});

  final String path;

}