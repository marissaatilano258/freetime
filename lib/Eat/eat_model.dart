class EatModel {
  int id;
  String name;
  String phone;
  String address;
  String website;

  EatModel.info(this.name, this.phone, this.address, this.website);

  EatModel(){}

  String toString() {
    return "{ id=$id, name=$name, phone=$phone, address=$address, website=$website}";
  }

}
