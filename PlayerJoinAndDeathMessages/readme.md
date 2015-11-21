Description:
Prints join message to chat when a player joins and death message when a player dies. Made it for Insurgency but should work for most games.

Cvar:

sm_deathmessage 1
Enables or disables death message

sm_joinmessage 1
Enables or disables join message

sm_dmsg "Long Live The Queen"
Death message to be printed goes between the quotes

sm_showcountry 1
Enables or disables Country code in join message

sm_lanonoroff 1
Enables or disables if LAN has to be printed in place of country code if lan client has connected

To install just put the plugin file in addons\sourcemod\plugins
The plugin auto generates .cfg file under cfg\sourcemod called plugin.PlayerJoinAndDeadMsg.cfg.

Changelog:
v1.0 - Intial Release
v1.1 - Made the death message configurable
V1.2 - Country code can be printed in join message
