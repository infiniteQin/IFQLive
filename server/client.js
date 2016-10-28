var ws = new WebSocket("ws://127.0.0.1:8080/");     
    
ws.onopen = function() {    
   alert("Opened");    
   ws.send("I'm client");    
};    
    
ws.onmessage = function (evt) {     
    alert(evt.data);    
};    
    
ws.onclose = function() {    
   alert("Closed");    
};    
    
ws.onerror = function(err) {    
   alert("Error: " + err);    
};