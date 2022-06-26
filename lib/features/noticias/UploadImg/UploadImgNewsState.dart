
abstract class UploadImgNewsState{}

class upload_sucessnew implements UploadImgNewsState{
  final String link;
  upload_sucessnew(this.link);

}
class upload_Loadingnew implements UploadImgNewsState{}

class upload_Errornew implements UploadImgNewsState{
  final String message;

  upload_Errornew(this.message);

}