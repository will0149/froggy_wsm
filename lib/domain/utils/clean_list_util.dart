

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/28/24
library;

class CleanListUtil {

  List<String> cleanList(String value){
    List<String> series = [];
    if(value.contains(" ")){
      series = value.split(" ");
    }
    return series;
  }

}