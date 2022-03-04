//-------------------------------------------------
//
//  SuperNova NPC System by erorcun
//
//-------------------------------------------------

#include <a_samp>

#define MAX_NPC (100) // CreateStreamedNPC limit
#define MAX_CONNECTED_NPC (50) // How many NPC will be connected at the same time - Must be lower than MAX_NPC - Can be equal too
#define STREAMED_NPC_DISTANCE (15)
#define MAX_NPC_NAME_LENGTH (15)
#define TIMER_INTERVAL (1000) // Default is 1000 ms
#define WALK_INTERVAL (100)

new npctimer;
new oyuncu;
new oyuncusayisi;
new streamednpc;

enum nInfo
{
	nname[MAX_NPC_NAME_LENGTH + 1],
	nskinid,
	Float:nx,
	Float:ny,
	Float:nz,
 	Float:nangle,
 	nid,
 	varmi,
 	onlinemi,
 	animvarmi,
 	animlib[64],
 	animname[64],
	Float:animspeed,
	animloop,
	animtimer,
	animfreeze,
	recordfile[64],
	recordtype,
	vw,
	vehicle,
	vehicleseat,
};
new NPCInfo[MAX_NPC][nInfo];

//-------------------------------------------------

public OnFilterScriptInit()
{
	print(" ");
	print("---------------- SuperNova NPC System Loaded ----------------");
	print("[!] System will be activated after the first player connected. ");
	print(" ");
	oyuncu = GetMaxPlayers();
	return 1;
}

//-------------------------------------------------

public OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
		oyuncusayisi ++;
		if(oyuncusayisi == 1)
		{
			npctimer = SetTimer("NPCControl",TIMER_INTERVAL,true);
		}
	}
	return 1;
}

//-------------------------------------------------

public OnPlayerDisconnect(playerid,reason)
{
	if(!IsPlayerNPC(playerid))
	{
		oyuncusayisi --;
		if(oyuncusayisi == 0)
		{
			KillTimer(npctimer);
		}
	}
	return 1;
}

//-------------------------------------------------

public OnFilterScriptExit()
{
	if(oyuncusayisi > 0) KillTimer(npctimer);
	return 1;
}

//-------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/recordplaybackcb", true))
	{
	    if(IsPlayerNPC(playerid))
	    {
			CallRemoteFunction("OnNPCRecordingPlaybackEnd","i",SN_GetStreamID(playerid));
			return 1;
		}
 		return 0;
	}
	return 0;
}
	
//-------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid))
	{
		new string2[MAX_NPC_NAME_LENGTH + 5];
		GetPlayerName(playerid,string2,sizeof(string2));
		format(string2,sizeof(string2),"%s.npc",string2);
		new File: UserFile = fopen(string2, io_read);
		if(UserFile)
		{
			new Data[16],val;
			while(fread(UserFile,Data,sizeof(Data)))
			{
				val = strval(Data);
				SetPVarInt(playerid,"StreamID",val);
				NPCInfo[val][nid] = playerid;
				SetSpawnInfo(playerid, 0, NPCInfo[val][nskinid], NPCInfo[val][nx], NPCInfo[val][ny], NPCInfo[val][nz], NPCInfo[val][nangle], -1, -1, -1, -1, -1, -1);
			}
			fclose(UserFile);
			fremove(string2);
		}
	}
	return 0;
}

//-------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
	{
	    new streamid = SN_GetStreamID(playerid);
		SetPlayerVirtualWorld(playerid,NPCInfo[streamid][vw]);
		if(NPCInfo[streamid][animvarmi] == 1)
		{
			ApplyAnimation(playerid,NPCInfo[streamid][animlib],"null",0.0,0,0,0,0,0);
  			SetTimerEx("ApplyAnim",3000,false,"i",playerid);
		}
		if(NPCInfo[streamid][vehicle] != 0)
		{
		    new Float:pos[3];
		    GetVehiclePos(NPCInfo[streamid][vehicle],pos[0],pos[1],pos[2]);
		    if(pos[0] == 0.0 && pos[1] == 0.0 && pos[2] == 0.0)
		    {
		        NPCInfo[streamid][vehicle] = 0;
			}
			else
			{
                PutPlayerInVehicle(playerid,NPCInfo[streamid][vehicle],NPCInfo[streamid][vehicleseat]);
			}
		}
		if(NPCInfo[streamid][recordtype] == 1)
		{
  			new naylon[64];
      		format(naylon,64,"type1=%s",NPCInfo[streamid][recordfile]);
			SendPlayerMessageToPlayer(playerid,playerid,naylon);
		}
		if(NPCInfo[streamid][recordtype] == 2)
		{
  			new naylon2[64];
      		format(naylon2,64,"type2=%s",NPCInfo[streamid][recordfile]);
			SendPlayerMessageToPlayer(playerid,playerid,naylon2);
		}
	}
	return 0;
}

forward ApplyAnim(npcid);
public ApplyAnim(npcid)
{
	new streamid = SN_GetStreamID(npcid);
	ApplyAnimation(npcid,NPCInfo[streamid][animlib],NPCInfo[streamid][animname],NPCInfo[streamid][animspeed],NPCInfo[streamid][animloop],1,1,NPCInfo[streamid][animfreeze],NPCInfo[streamid][animtimer]);
	return 1;
}

forward CreateNPC(streamid);
public CreateNPC(streamid)
{
	NPCInfo[streamid][onlinemi] = 1;
	new stringer[MAX_NPC_NAME_LENGTH + 5];
	format(stringer,sizeof(stringer),"%s.npc",NPCInfo[streamid][nname]);
	new File: hFile = fopen(stringer, io_write);
	if (hFile)
	{
		format(stringer,sizeof(stringer),"%i",streamid);
		fwrite(hFile, stringer);
		fclose(hFile);
	}
	ConnectNPC(NPCInfo[streamid][nname],"bot");
	return 1;
}

forward SN_CreateStreamedNPC(const name[], skin, Float:x, Float:y, Float:z, Float:angle,viwo);
public SN_CreateStreamedNPC(const name[], skin, Float:x, Float:y, Float:z, Float:angle,viwo)
{
	for(new i = 0;i<MAX_NPC;i++)
	{
	    if(NPCInfo[i][varmi] != 1)
		{
			new stringer[MAX_NPC_NAME_LENGTH + 1];
			format(stringer,sizeof(stringer),"%s",name);
			NPCInfo[i][nname] = stringer;
			NPCInfo[i][nskinid] = skin;
			NPCInfo[i][nx] = x;
			NPCInfo[i][ny] = y;
			NPCInfo[i][nz] = z;
			NPCInfo[i][nangle] = angle;
			NPCInfo[i][varmi] = 1;
			NPCInfo[i][onlinemi] = 0;
			NPCInfo[i][animvarmi] = 0;
			NPCInfo[i][recordtype] = -1;
			NPCInfo[i][vw] = viwo;
			return i;
		}
	}
	return -1;
}

forward SN_WalkNPC(streamid,walkid,Float:x,Float:y,Float:z,bool:run);
public SN_WalkNPC(streamid,walkid,Float:x,Float:y,Float:z,bool:run)
{
	new Float:xe,Float:ye,Float:ze, obje,oyuncuid;
	oyuncuid = NPCInfo[streamid][nid];
	SetPVarInt(oyuncuid,"walkid",walkid);
	ApplyAnimation(oyuncuid,"ped","null",0.0,0,0,0,0,0);
	if(GetPVarType(oyuncuid,"naber") == 1)
	{
		KillTimer(GetPVarInt(oyuncuid,"naber"));
		DeletePVar(oyuncuid,"naber");
	}
	if(GetPVarType(oyuncuid,"walkobject") == 1)
	{
		DestroyObject(GetPVarInt(oyuncuid,"walkobject"));
		DeletePVar(oyuncuid,"walkobject");
	}
	SetPlayerLookAt(oyuncuid,x,y);
	GetPlayerPos(oyuncuid,xe,ye,ze);
	obje = CreateObject(1248, xe, ye, ze-100, 0, 0, 0);
	SetPVarInt(oyuncuid,"walkobject",obje);
	SetPVarInt(oyuncuid,"naber",SetTimerEx("Walk",WALK_INTERVAL,true,"ii",streamid,obje));
	if(run)
	{
		SN_ApplyNPCAnimation(oyuncuid,"ped","run_player",4.1,1,1,1);
		MoveObject(obje,x,y,z-100,5.0);
	}
	else
	{
		SN_ApplyNPCAnimation(oyuncuid,"ped","WALK_player",4.1,1,1,1);
		MoveObject(obje,x,y,z-100,1.5);
	}
	return 1;
}

forward Walk(streamid,objectid);
public Walk(streamid,objectid)
{
	new Float:xe,Float:ye,Float:ze,Float:xb,Float:yb,Float:zb,player;
	player = NPCInfo[streamid][nid];
	GetObjectPos(objectid,xe,ye,ze);
	GetPlayerPos(player,xb,yb,zb);
	if(xe == xb && ye == yb && ze+100 == zb)
	{
	    SN_StopWalkNPC(streamid,0);
	    return 1;
	}
	if(NPCInfo[streamid][onlinemi] == 1)
	{
		SetPlayerPos(player,xe,ye,ze+100);
	}
	else
	{
		NPCInfo[streamid][nx] = xe;
		NPCInfo[streamid][ny] = ye;
		NPCInfo[streamid][nz] = ze+100;
	}
	return 1;
}

forward SN_StopWalkNPC(streamid,method);
public SN_StopWalkNPC(streamid,method)
{
	new player = NPCInfo[streamid][nid];
	if(GetPVarType(player,"walkobject") == 1)
	{
		KillTimer(GetPVarInt(player,"naber"));
		SN_ClearNPCAnimations(streamid);
		DestroyObject(GetPVarInt(player,"walkobject"));
		CallRemoteFunction("OnNPCWalkEnd","iii",streamid,GetPVarInt(player,"walkid"),method);
		DeletePVar(player,"walkid");
		DeletePVar(player,"naber");
		DeletePVar(player,"walkobject");
		return 1;
	}
	return 0;
}

stock SetPlayerLookAt(playerid, Float:x, Float:y)
{
	new Float:Px, Float:Py, Float: Pa;
	GetPlayerPos(playerid, Px, Py, Pa);
	Pa = floatabs(atan((y-Py)/(x-Px)));
	if (x <= Px && y >= Py) Pa = floatsub(180, Pa);
	else if (x < Px && y < Py) Pa = floatadd(Pa, 180);
	else if (x >= Px && y <= Py) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	SetPlayerFacingAngle(playerid, Pa);
}


forward NPCControl();
public NPCControl()
{
	for(new i = 0;i<MAX_NPC;i++)
	{
		if(NPCInfo[i][varmi] == 1 && NPCInfo[i][recordtype] == -1)
		{
			if(GetClosestPlayer(i) != -1)
			{
			    if(NPCInfo[i][onlinemi] == 0)
			    {
			        if(streamednpc < MAX_CONNECTED_NPC)
					{
					    streamednpc ++;
						CreateNPC(i);
					}
				}
			}
			else
			{
			    if(NPCInfo[i][onlinemi] == 1)
			    {
					new Float:xes,Float:yes,Float:zes,Float:angles;
					GetPlayerPos(NPCInfo[i][nid],xes,yes,zes);
					GetPlayerFacingAngle(NPCInfo[i][nid],angles);
					NPCInfo[i][nx] = xes;
					NPCInfo[i][ny] = yes;
					NPCInfo[i][nz] = zes;
					NPCInfo[i][nangle] = angles;
					NPCInfo[i][nskinid] = GetPlayerSkin(NPCInfo[i][nid]);
					NPCInfo[i][vw] = GetPlayerVirtualWorld(NPCInfo[i][nid]);
					NPCInfo[i][onlinemi] = 0;
					NPCInfo[i][vehicle] = GetPlayerVehicleID(NPCInfo[i][nid]);
					if(NPCInfo[i][vehicle] != 0)
					{
						NPCInfo[i][animvarmi] = 0;
						NPCInfo[i][vehicleseat] = GetPlayerVehicleSeat(NPCInfo[i][nid]);
					}
					streamednpc --;
					Kick(NPCInfo[i][nid]);
				}
			}
		}
	}
	return 1;
}

stock GetDistanceBetweenPlayers(playerid, npcstreamid)
{
    new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2;
    new Float:tmpdis;
    GetPlayerPos(playerid, x1, y1, z1);
    x2 = NPCInfo[npcstreamid][nx];
    y2 = NPCInfo[npcstreamid][ny];
    z2 = NPCInfo[npcstreamid][nz];
    tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2, x1)), 2) + floatpower(floatabs(floatsub(y2, y1)), 2) + floatpower(floatabs(floatsub(z2, z1)), 2));
    return floatround(tmpdis);
}

stock GetClosestPlayer(streamid)
{
    new Float:dis,Float:dis2,player,sayi;
    player = -1;
    dis = STREAMED_NPC_DISTANCE;
    for(new i = 0; i < oyuncu; i++)
    {
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    sayi ++;
    		dis2 = GetDistanceBetweenPlayers(i, streamid);
    		if((dis2 < dis) && (dis2 != -1.00))
    		{
    			dis = dis2;
    			player = i;
   			}
    	}
    	if(sayi == oyuncusayisi)
    	{
    	    break;
    	}
	}
	return player;
}

forward SN_GetStreamID(npcid);
public SN_GetStreamID(npcid)
{
	if(IsPlayerNPC(npcid))
	{
	    return GetPVarInt(npcid,"StreamID");
	}
	return -1;
}

forward SN_SetNPCPos(streamid,Float:x,Float:y,Float:z);
public SN_SetNPCPos(streamid,Float:x,Float:y,Float:z)
{
	if(NPCInfo[streamid][varmi] == 1)
	{
		NPCInfo[streamid][nx] = x;
		NPCInfo[streamid][ny] = y;
		NPCInfo[streamid][nz] = z;
        if(NPCInfo[streamid][onlinemi] == 1)
        {
            SetPlayerPos(NPCInfo[streamid][nid],x,y,z);
        }
	    return 1;
	}
	return 0;
}

forward SN_SetNPCFacingAngle(streamid,Float:angle);
public SN_SetNPCFacingAngle(streamid,Float:angle)
{
	if(NPCInfo[streamid][varmi] == 1)
	{
		NPCInfo[streamid][nangle] = angle;
        if(NPCInfo[streamid][onlinemi] == 1)
        {
            SetPlayerFacingAngle(NPCInfo[streamid][nid],angle);
        }
	    return 1;
	}
	return 0;
}

forward SN_SetNPCVirtualWorld(streamid,virtualworld);
public SN_SetNPCVirtualWorld(streamid,virtualworld)
{
	if(NPCInfo[streamid][varmi] == 1)
	{
		NPCInfo[streamid][vw] = virtualworld;
        if(NPCInfo[streamid][onlinemi] == 1)
        {
            SetPlayerVirtualWorld(NPCInfo[streamid][nid],virtualworld);
        }
	    return 1;
	}
	return 0;
}

forward SN_SetNPCSkin(streamid,skinid);
public SN_SetNPCSkin(streamid,skinid)
{
	if(NPCInfo[streamid][varmi] == 1)
	{
		NPCInfo[streamid][nskinid] = skinid;
        if(NPCInfo[streamid][onlinemi] == 1)
        {
            SetPlayerSkin(NPCInfo[streamid][nid],skinid);
        }
	    return 1;
	}
	return 0;
}

forward SN_DestroyStreamedNPC(streamid);
public SN_DestroyStreamedNPC(streamid)
{
	if(NPCInfo[streamid][varmi] == 1)
	{
	    NPCInfo[streamid][varmi] = 0;
	    NPCInfo[streamid][animvarmi] = 0;
	    NPCInfo[streamid][recordtype] = -1;
	    if(NPCInfo[streamid][onlinemi] == 1)
	    {
	        Kick(NPCInfo[streamid][nid]);
	        NPCInfo[streamid][onlinemi] = 0;
		}
		return 1;
	}
	return 0;
}

forward SN_ApplyNPCAnimation(streamid,animlibs[],animnames[],Float:fS,timer,freeze,loop);
public SN_ApplyNPCAnimation(streamid,animlibs[],animnames[],Float:fS,timer,freeze,loop)
{
	if(NPCInfo[streamid][varmi] == 1)
	{
		new kro[64];
		format(kro,64,"%s",animlibs);
		NPCInfo[streamid][animlib] = kro;
		format(kro,64,"%s",animnames);
		NPCInfo[streamid][animname] = kro;
		NPCInfo[streamid][animspeed] = fS;
		NPCInfo[streamid][animtimer] = timer;
		NPCInfo[streamid][animfreeze] = freeze;
		NPCInfo[streamid][animloop] = loop;
		NPCInfo[streamid][animvarmi] = 1;
		if(NPCInfo[streamid][onlinemi] == 1)
		{
		    ApplyAnimation(NPCInfo[streamid][nid],animlibs,animnames,fS,loop,1,1,freeze,timer);
		}
	}
	return 1;
}

forward SN_ClearNPCAnimations(streamid);
public SN_ClearNPCAnimations(streamid)
{
	if(NPCInfo[streamid][varmi] == 1)
	{
		NPCInfo[streamid][animvarmi] = 0;
		if(NPCInfo[streamid][onlinemi] == 1)
		{
		    ClearAnimations(NPCInfo[streamid][nid]);
		}
	}
	return 1;
}

forward SN_StartRecordingPlayback(streamid,playbacktype,recordname[]);
public SN_StartRecordingPlayback(streamid,playbacktype,recordname[])
{
	if(NPCInfo[streamid][varmi] == 1)
	{
		strmid(NPCInfo[streamid][recordfile],recordname,0,strlen(recordname));
		NPCInfo[streamid][recordtype] = playbacktype;
		NPCInfo[streamid][animvarmi] = 0;
		SN_StopWalkNPC(streamid,2);
		if(NPCInfo[streamid][onlinemi] == 0)
	 	{
			CreateNPC(streamid);
		}
		else
		{
		    ClearAnimations(NPCInfo[streamid][nid]);
			if(NPCInfo[streamid][recordtype] == 1)
			{
	  			new naylon[64];
	      		format(naylon,64,"type1=%s",recordname);
				SendPlayerMessageToPlayer(NPCInfo[streamid][nid],NPCInfo[streamid][nid],naylon);
			}
			if(NPCInfo[streamid][recordtype] == 2)
			{
	  			new naylon2[64];
	      		format(naylon2,64,"type2=%s",recordname);
				SendPlayerMessageToPlayer(NPCInfo[streamid][nid],NPCInfo[streamid][nid],naylon2);
			}
		}
	}
	return 1;
}

forward SN_StopRecordingPlayback(streamid);
public SN_StopRecordingPlayback(streamid)
{
	if(NPCInfo[streamid][varmi] == 1)
	{
		NPCInfo[streamid][recordtype] = -1;
		strmid(NPCInfo[streamid][recordfile],"",0,0);
		SendPlayerMessageToPlayer(NPCInfo[streamid][nid],NPCInfo[streamid][nid],"stoprecord");
	}
	return 1;
}

