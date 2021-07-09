class ApiResponse<T> {
  Status? status;
  Object? data;
  String? message;
  int? requestcode;

  ApiResponse.loading(this.message,this.requestcode) : status = Status.LOADING;
  ApiResponse.completed(this.data,this.requestcode) : status = Status.COMPLETED;
  ApiResponse.error(this.message,this.requestcode) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
