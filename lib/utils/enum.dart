
enum ApiCallStatus {
  loading,
  success,
  error,
  empty,
  holding,
  cache,
  refresh,
}


enum ScreenTypes{
  mobile,
  tablet
}

enum Services{
  configurator("1","Configurator"),
  fieldWork("2","FieldWork"),
  itmmServices("3","ITMM Services");
  final String id;
  final String value;
  const Services(this.id,this.value);
}

enum UserType{
  employee("1","Employee"),
  customer("2","Customer");
  final String id;
  final String value;
  const UserType(this.id,this.value);
}