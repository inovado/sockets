//fl-page  CREA UN STATELESS WIDGET
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sockets/models/band.dart';
import 'package:sockets/services/socket_service.dart';
import 'package:provider/provider.dart';

//-----------------------------------------------------------
//STATE DEL STATEFULWIDGET
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    // Band(id: '1', name: 'Metallica', votes: 5),
    // Band(id: '2', name: 'Guns', votes: 3),
    // Band(id: '3', name: 'Roses', votes: 2),
    // Band(id: '4', name: 'Oasis', votes: 1),
    // Band(id: '5', name: 'Creed', votes: 6),

  ];

  @override
  void initState() { 

    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _handleActiveBands); //listener
    super.initState();
  }

  _handleActiveBands(dynamic payload){
     this.bands = (payload as List)
        .map((band) => Band.fromMap(band))
        .toString() as List<Band>;

      setState(() { });
  }





  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87), textAlign: TextAlign.center,),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: ( socketService.serverStatus == ServerStatus.Online)
            ? Icon(Icons.check_circle, color: Colors.blue[300],) // si esta conectado ! entonces!
            : Icon(Icons.offline_bolt, color: Colors.red),

          )
        ],
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) => _bandTile(bands[index]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 1,
          onPressed: addNewBand // manda unicamente la referencia, por eso no lleva los parentesis al final
          
          ),
   );
  }

  Widget _bandTile(Band band){
    final socketService = Provider.of<SocketService>(context, listen: false);


    return Dismissible(
          key: Key(band.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (_){
            // print('direction: $direction');
            // print('id: ${band.id}');
            socketService.emit('delete-band', {'id': band.id});

          },
          background: Container(
            padding: EdgeInsets.only(left: 8.0),
            color: Colors.red,
            child: Align(
              alignment: Alignment.center,
              child: Text('Delete Band', style: TextStyle(color: Colors.white),)
              ),
          ),
          child: ListTile(
             leading: CircleAvatar(
              child: Text(band.name.substring(0,2)),
              backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${ band.votes}',style: TextStyle(fontSize: 20),),
        onTap: ()=> socketService.socket.emit('vote-band',{ 'id':band.id }),

      ),
    );
  }
  addNewBand(){

    // para administrar el texto que se introduce
    final textController = new TextEditingController();

    
    if (Platform.isAndroid) { //version para android
        return showDialog(
                context: context,
                builder: ( _ ) => AlertDialog(
                    title: Text('New band name: '),
                    content: TextField( controller: textController,),
                    actions: <Widget>[
                      MaterialButton(
                        child: Text('add'),
                        elevation: 5,
                        textColor: Colors.blue,
                        onPressed: () => addBandToList(textController.text),
                        )
                    ],
                  )
                
              );
    }
    
    showCupertinoDialog( // para IOS
      context: context, 
      builder: ( _ ) =>CupertinoAlertDialog(  // cuando no se utiliza el context se utiliza un guion bajo
          title: Text('New band name: '),
          content: CupertinoTextField(
            controller: textController,
            ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context)
            ),
          
          ],
        )
      
      );

  }

void addBandToList(String name){

  if (name.length > 1) {

    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.emit('add-band',{'name': name});
   

  }
  Navigator.pop(context);

  
  }


}


//-----------------------------------------------------------