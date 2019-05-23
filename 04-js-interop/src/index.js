import './main.css';
import { Elm } from './Main.elm';

// Bootstrap Elm
var app = Elm.Main.init({
    node: document.getElementById('app'),
    flags: {"message": "Hello world!","cache": localStorage.getItem('cache'), "cacheState": ""}
});

app.ports.cache.subscribe(function(data) {
    localStorage.setItem('cache', data);
    app.ports.dataEvent.send("Set");
  });

  app.ports.clearCache.subscribe(function() {
      localStorage.removeItem('cache');
      app.ports.dataEvent.send("Cleared");
  });
  

  

//app.ports.cache.send(localStorage.getItem('cache'));