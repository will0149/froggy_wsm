

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

const double wrapVerticalSpacing = 20.0;
const double wrapHorizontalSpacing = 10.0;

final List<String> clients = ['Cliente 1', 'Cliente 2', 'Cliente 3'];

final List<String> bodegas = ['Bodega 1', 'Bodega 2', 'Bodega 3'];

// inbound POST
// https://cct-api.froggysoft.app/api/v1/inbound
//     {
// "docnum": "",
// "lpn": "",
// "customer": "",
// "warehouse": "",
// "location": "",
// "batch": "",
// "serie": "",
// "expiry_at": "",
// "condition": "",
// "quantity": "",
// "entry_at": "",
// "remarks": ""
// }
//
// outbound POST
// https://cct-api.froggysoft.app/api/v1/outbound
//
//     {
// "docnum": "",
// "lpn": "",
// "customer": "",
// "warehouse": "",
// "location": "",
// "batch": "",
// "serie": "",
// "quantity": "",
// "exit_at": "",
// "remarks": ""
// }
//
// relocation POST
// https://cct-api.froggysoft.app/api/v1/relocation
// {
// "serie": "",
// "lpn": "",
// "towardswarehouse": "",
// "towardslocation": "",
// "fromwarehouse": "",
// "fromlocation": "",
// "quantity": "",
// "remarks": ""
// }
//
// tally POST
// https://cct-api.froggysoft.app/api/v1/tally
//     {
// "warehouse": "",
// "location": "",
// "lpn": "",
// "serie": "",
// "quantity": "",
// "remark": ""
// }