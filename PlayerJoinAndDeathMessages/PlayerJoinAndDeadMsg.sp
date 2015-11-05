#pragma semicolon 1

#include <sourcemod>

public Plugin myinfo = 
{
	name = "Death and join message",
	author = "RNR",
	description = "Prints death and join message",
	version = "1.1",
	url = "www.sourcemod.net"
};

ConVar g_cvDeathMsgEnabled;
ConVar g_cvJoinMsgEnabled;
ConVar g_cvDeathMsg;

public void OnPluginStart() {
	HookEvent("player_death", Player_Death_Event);
	g_cvDeathMsgEnabled = CreateConVar("sm_deathmessage", "1", "Determines if the death message should be printed or not.",FCVAR_NOTIFY);
	g_cvJoinMsgEnabled = CreateConVar("sm_joinmessage", "1", "Determines if the join message should be printed or not.", FCVAR_NOTIFY);
	g_cvDeathMsg = CreateConVar("sm_dmsg", "Long Live The Queen", "The Message that is printed on screen after \"<player> is dead.", FCVAR_NOTIFY);
	AutoExecConfig(true);
}

public Action:Player_Death_Event(Handle:event, const String:name[], bool:dontbroadcast)
{
	if (!GetConVarBool(g_cvDeathMsgEnabled)) 
		return Plugin_Handled;
	
	new client;
	new clientid;
	decl String:nick[32];
	decl String:msg[120];
	clientid = GetEventInt(event, "userid");
	client = GetClientOfUserId(clientid);
	GetConVarString(g_cvDeathMsg, msg, 120);
	GetClientName(client, nick, sizeof(nick));
	if (!IsFakeClient(client)) 
	{
		PrintCenterTextAll("%s is dead. %s", nick, msg);
	}
	return Plugin_Handled;
}

public OnClientPutInServer(client)
{
	if (!GetConVarBool(g_cvJoinMsgEnabled)) 
		return;
	
	decl String:name[32];

	GetClientName(client, name, sizeof(name));
	
	if(!IsFakeClient(client))
	{
		PrintToChatAll("\x01%s\x01\x04 has joined. Sit tight.", name);
	}
}