class ApiResponse<T>{
  bool ok;
  String msg;
  T result;
  int resCode;

  ApiResponse.ok({this.result, this.msg}){
    resCode = 200;
    ok = true;
  }

  ApiResponse.error({this.result, this.msg}){
    ok = false;
  }
}