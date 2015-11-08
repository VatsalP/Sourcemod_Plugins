#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "RNR"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>

float intial;

public Plugin myinfo = 
{
	name = "Say Time",
	author = PLUGIN_AUTHOR,
	description = "Say timespent on server",
	version = PLUGIN_VERSION,
	url = "www.sourcemod.net"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_time", SayTime);
}

public OnClientPutInServer(client) 
{
	if(!IsFakeClient(client)) {
		intial = GetClientTime(client);
	}
}

public Action SayTime(int client, int args)
{
		float time;
		time = GetClientTime(client);
		time = FloatSub(time, intial);
		time = FloatAbs(time);
		
		ReplyToCommand(client, "\x01You have spent \x04%f\x01 second on the server", time);
		return Plugin_Handled;
}

