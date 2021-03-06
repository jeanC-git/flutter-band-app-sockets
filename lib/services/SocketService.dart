import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  IO.Socket _socket;
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    String urlSocket = 'http://192.168.1.14:3005';
    // String urlSocket = 'https://flutter-socket-io-server-jc.herokuapp.com/';

    this._socket = IO.io(
        urlSocket,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build());

    this._socket.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
      // this._socket.emit('msg', 'test');
    });
    this._socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje: $payload');
    });
  }
}
