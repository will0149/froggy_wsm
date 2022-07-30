

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/01/22
 */
class ResponseEntity<E> {
  final E? body;

  ResponseEntity({ this.body});

  factory ResponseEntity.fromJson(Map<String, dynamic> json) => ResponseEntity(
    body: json["events"],
  );

  Map<String, dynamic> toJson() => {
    "body": body,
  };
}