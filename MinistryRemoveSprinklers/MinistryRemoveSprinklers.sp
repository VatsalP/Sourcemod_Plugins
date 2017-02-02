#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Vatsal Parekh"
#define PLUGIN_VERSION "0.1"

#include <sourcemod>
#include <sdktools>
#include <regex>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "Minstry Remove Sprinklers",
	author = PLUGIN_AUTHOR,
	description = "Removes the sprinklers from Ministry map",
	version = PLUGIN_VERSION,
	url = "https://github.com/VatsalP/Sourcemod_Plugins"
};

Handle cv_remove = INVALID_HANDLE; // DO WE REMOVE THE DAMN SPRINKLERS? YES WE DO!

public void OnPluginStart()
{
	cv_remove = CreateConVar("sm_remove", "1", "Remove the sprinklers from ministry(1/0)", FCVAR_NOTIFY);
	
	if (GetConVarBool(cv_remove))
	{
		HookEvent("round_start", RoundStart);
	}
}

public Action RoundStart(Event event, const char[] name, bool dontbroadcast) // Creates a timer every round of 15 seconds
{
	char mapname[20];
	Handle r = CompileRegex("ministry");
	
	GetCurrentMap(mapname, 21);
	//if (GetRegexSubString(r, 0, mapname, 21))
	//{
		PrintToServer("It Works bro");
	//}
}