#pragma semicolon 1

#include <sourcemod>

public Plugin:myinfo = 
{
	name = "Speclist",
	author = "SeriTools",
	description = "Downloads and Precaches Files",
	version = "1.0.0",
	url = "https://github.com/SeriTools/sm_speclist"
}

public OnPluginStart()
{
	RegConsoleCmd("sm_speclist", SpeclistCommand, "Lists all current spectators");
}

public Action:SpeclistCommand(client, args)
{
    new String:SpecNames[MaxClients / 2 + 1][33];
    decl String:name1[33];
    decl String:name2[33];
    new namecount = 0;

    for (new cl = 1; cl <= MaxClients; cl++) {
        if (IsClientInGame(cl) && IsClientObserver(cl)) {
            if (namecount % 2 == 0) {
                GetClientName(cl, name1, sizeof(name1));
            }
            else {
                GetClientName(cl, name2, sizeof(name2));
                ReplyToCommand(client, "%s, %s", name1, name2);
            }
            namecount++;
        }
    }

    if (namecount % 2 == 1) {
        ReplyToCommand(client, "%s", name1);   
    }

    ReplyToCommand(client, "\x01Number of Spectators: \x04%i", namecount); 

    return Plugin_Handled;
}