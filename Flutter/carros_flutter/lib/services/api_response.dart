class ApiResponse<T>{
  bool ok;
  String msg;
  T result;
  int resCode;

  ApiResponse.ok(this.result){
    resCode = 200;
    ok = true;
  }

  ApiResponse.error(this.resCode, this.msg){
    ok = false;
  }
  ApiResponse.erro(this.msg){
    ok = false;
  }
}