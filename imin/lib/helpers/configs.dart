// ip service

const String domainName = "https://vms-service.ngrok.io";
const String ipServer = domainName + "/web_api";
const String ipServerIminService = domainName +  "/imin_walkin_api";


// SocketIO Server
const String socketUrl = "https://socketio-service.ngrok.io";
const String socketAuth = "0edf3e46-8c78-49da-8980-a96eb3263941";


// Gate Birrer Server
String gateBarrierOpenUrl =
    "http://192.168.1.9/user=admin&password=secret&command=OpenGate";
String gateBarrierCloseUrl =
    "http://192.168.1.9/user=admin&password=secret&command=CloseGate";
    