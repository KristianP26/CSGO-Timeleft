#pragma tabsize 0
#include <sourcemod>

public Plugin myinfo = 
{
	name = "Timeleft",
	author = "KristiánP",
	description = "Shows Timeleft",
	version = "1.0"
};

public void OnPluginStart()
{
	CreateTimer(1.0, Timeleft, _, TIMER_REPEAT);
}

public Action Timeleft(Handle timer)
{
	char TimeFormated[60];
	int TimeleftSec;

	GetMapTimeLeft(TimeleftSec);

	if(TimeleftSec > 0)
	{
		FormatTime(TimeFormated, sizeof(TimeFormated), "%M:%S", TimeleftSec);

		for(int i = 1; i <= MaxClients; i++)
		{
			if(IsClientInGame(i) && !IsFakeClient(i))
			{
				char message[120];
				Format(message, sizeof(message), "Timeleft: %s", TimeFormated);
				if(TimeleftSec > 300){
					SetHudTextParams(-1.0, 1.00, 1.0, 17, 121, 195, 255, 0, 0.00, 0.00, 0.00);
				} else if(TimeleftSec > 180){
					SetHudTextParams(-1.0, 1.00, 1.0, 204, 204, 0, 255, 0, 0.00, 0.00, 0.00);
				} else {
					SetHudTextParams(-1.0, 1.00, 1.0, 252, 21, 21, 255, 0, 0.00, 0.00, 0.00);
				}
				ShowHudText(i, -1, message);
			}
		}
	}
	return Plugin_Continue;
}