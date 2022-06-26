
abstract class Upload_img_state{}

class upload_sucess implements Upload_img_state{
  final String link;
  upload_sucess(this.link);

}
class upload_Loading implements Upload_img_state{}

class upload_Error implements Upload_img_state{
  final String message;

  upload_Error(this.message);

}