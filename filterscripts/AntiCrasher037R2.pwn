#include <a_samp>
#define BulletCrasher -5.5
#define InvalidSeat1 -1000000.0
#define InvalidSeat2 1000000.0
#define red 0xFF0000FF

//Anti Crasher 0.3.7 R2 by [MD]_Shift | skype: dima.shift |

public OnPlayerUpdate(playerid){
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid,X,Y,Z);
	if Z == BulletCrasher || !(InvalidSeat1 <= Z <= InvalidSeat2) *then {
		new tipcrasher[20];
		tipcrasher="BadVehicleCrasher";
		if Z == BulletCrasher *then tipcrasher="BulletCrasher";
		new string[MAX_CHATBUBBLE_LENGTH];
		format(string,sizeof(string),"[Anti-CrasherHack]: {FFFF00}%s {999999}|ID:%d| {00FF00}auto-kick {FF0000}[Motivo: %s]",GetName(playerid),playerid,tipcrasher);
		SendClientMessageToAll(red,string);
		Kick(playerid);
		return false;
	}
	return true;
}

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}
