
abstract class UploadState {}

class UploadLoading implements UploadState{

  const UploadLoading();
}

class UploadSucess implements UploadState{
  final Map data;

  const UploadSucess(this.data);
}
class UploadError implements UploadState{
  final String message;

  const UploadError(this.message);
}