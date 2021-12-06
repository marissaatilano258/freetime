class DoModel {
  int id;
  String name;
  String location;
  String date;
  String time;
  String website;

  DoModel.info(this.name, this.location, this.date, this.time, this.website);

  DoModel(){}

  String toString() {
    return "{ id=$id, name=$name, location=$location, date=$date, time=$time, website=$website}";
  }

}
