// ip service

const String domainName = "http://vms-service.ngrok.io";
const String ipServer = domainName + "/web_api";
const String ipServerIminService = domainName +  "/imin_walkin_api";

String gateBarrierOpenUrl =
    "http://192.168.1.9/user=admin&password=secret&command=OpenGate";
String gateBarrierCloseUrl =
    "http://192.168.1.9/user=admin&password=secret&command=CloseGate";
    