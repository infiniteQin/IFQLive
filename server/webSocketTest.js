var WebSocketServer = require('ws').Server
  , wss = new WebSocketServer({port: 8080});

console.log("Server Started. port : " + 8080);

var wsDic = {};

var users = {"aaa":"123","bbb":"123456"};

//==============登录====================
var onLogin = function( ws, usrName, pwd) {
	if (!usrName) {
		ws.send('请输入用户名');
		return;
	}

	if (users[usrName] != pwd) {
		ws.send('用户名或密码错误');
		return;
	}
	wsDic[usrName] = ws;
	ws.hasLogin = true;
	ws.send('登录成功');
};

//==============接收&转发消息====================
var onTextMsg = function(ws,toUsr,text) {

	if (!ws.hasLogin) {
		ws.send('未登录,请先登录');
		return;
	}

	var tows = wsDic[toUsr];
	if (tows && tows.hasLogin) {
		console.log('say to '+toUsr+':'+text);
		tows.send(text);
	}
};

wss.on('connection', function(ws) {
    ws.on('message', function(message) {
        console.log('received: %s', message);
        var msg
        try {
        	msg = JSON.parse(message);
    	}catch(ex) {
    		console.log('解析错误');
    		ws.send('数据异常');
    		return;
    	}
    	switch (msg.type) {
    	case 1000:
    		onLogin(ws,msg.usrname,msg.password);
    		break;
    	case 1:
    		onTextMsg(ws,msg.toUsr,msg.content);
    		break;
    	}

    });
    
    ws.send('connection succ');

});