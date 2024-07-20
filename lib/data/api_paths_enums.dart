

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

enum ApiPathsEnums {

  host(path: 'cct-api.froggysoft.app'),
  v1(path: '/api/v1'),
  inbound(path: '/api/v1/inbound'),
  outgoing(path: '/api/v1/outbound'),
  count(path: '/api/v1/tally'),
  countValidate(path: '/api/v1/tally/compare'),
  relocation(path: '/api/v1/relocation'),
  clients(path: '/api/v1/customers'),
  warehouses(path: '/api/v1/warehouses');

  const ApiPathsEnums({required this.path});

  final String path;

}