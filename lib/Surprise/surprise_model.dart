class SurpriseModel {
  int id;
  String surprise;
  String type;
  String participants;

  SurpriseModel.info(this.surprise, this.type, this.participants);

  SurpriseModel();

  String toString() {
    return "{ id=$id, surprise=$surprise, type=$type, participants=$participants}";
  }

}
