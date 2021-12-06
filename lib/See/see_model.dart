class SeeModel {
  int id;
  String name;
  String description;
  String vote;
  String releaseDate;
  String image;

  SeeModel.info(this.name, this.description, this.vote, this.releaseDate, this.image);

  SeeModel();

  String toString() {
    return "{ id=$id, name=$name, description=$description, vote=$vote, releaseDate=$releaseDate, image=$image}";
  }

}
