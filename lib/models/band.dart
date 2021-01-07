

class Band{

  String id;
  String name;
  int votes;

  Band({ // constructor
    this.id,
    this.name,
    this.votes
  });

  factory Band.fromMap(Map<String, dynamic> obj)  => Band( //factory constructor regresa una nueva instancia de la clase por medio de un Map
    id: obj['id'],
    name: obj['name'],
    votes: obj['votes']
    );





}