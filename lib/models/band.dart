

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
    id: obj.containsKey('id') ? obj['id'] : 'no-id',
    name: obj.containsKey('name') ? obj['name'] : 'no-name',
    votes: obj.containsKey('votes') ? obj['votes'] : 'no-votes'
    );





}