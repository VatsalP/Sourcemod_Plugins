#pragma semicolon 1

#define PLUGIN_AUTHOR "RNR"
#define PLUGIN_VERSION "0.1"

#include <sourcemod>

char Path[PLATFORM_MAX_PATH];
Handle fortuneCommand = INVALID_HANDLE;

public Plugin myinfo = 
{
	name = "Fortune port :D",
	author = PLUGIN_AUTHOR,
	description = "Sourcemod port of Fortune",
	version = PLUGIN_VERSION,
	url = "www.sourcemod.net"
};

public void OnPluginStart()
{
	BuildPath(Path_SM, Path, sizeof(Path), "data/fortune.txt");
	fortuneCommand = CreateConVar("sm_fortunecomnoroff", "1", "Enable or Disable(1/0) /fortune, !fortune and sm_fortune.", FCVAR_NOTIFY | FCVAR_PLUGIN);
	if(GetConVarBool(fortuneCommand))
		RegConsoleCmd("sm_fortune", ReadAFortune);
}

public OnClientPutInServer(client)
{
	CreateTimer(15.0, Fortune, client);
}
public Action ReadAFortune(int client, int args)
{
	Handle file = OpenFile(Path, "r");
	decl String:text[4096], String:buffer[1024];
	int len = 0;
	int random, count = 0;
	if(file == INVALID_HANDLE)
	{
		LogError("Cannot connect to Fortune.txt");
		return Plugin_Handled;
	}
	random = GetRandomInt(1, 3518);
	
	while(!IsEndOfFile(file) && ReadFileLine(file, buffer, sizeof(buffer)))
	{
		if(buffer[0] == '%')
		{
			count++;
		}
		if(count == random)
		{
				if(buffer[0] != '%')
				{
					len += Format(text[len], sizeof(text)-len, "%s", buffer);
				}
		}
		if(count > random)
			break;
	}
	ReplyToCommand(client, "%s", text);
	
	return Plugin_Handled;
}

public Action Fortune(Handle Timer, any client)
{
	Handle file = OpenFile(Path, "r");
	decl String:text[4096], String:buffer[1024];
	int len = 0;
	int random, count = 0;
	if(file == INVALID_HANDLE)
	{
		LogError("Cannot connect to Fortune.txt");
		return Plugin_Handled;
	}
	random = GetRandomInt(1, 3518);
	
	while(!IsEndOfFile(file) && ReadFileLine(file, buffer, sizeof(buffer)))
	{
		if(buffer[0] == '%')
		{
			count++;
		}
		if(count == random)
		{
				if(buffer[0] != '%')
				{
					len += Format(text[len], sizeof(text)-len, "%s", buffer);
				}
		}
		if(count > random)
			break;
	}
	
	PrintToChat(client, "%s", text);
	
	return Plugin_Handled;
}