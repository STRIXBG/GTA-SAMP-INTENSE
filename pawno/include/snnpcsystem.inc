#if defined _snnpcsystem_included
	#endinput
#endif
#define _snnpcsystem_included

#include <a_samp>

// Callbacks

forward OnNPCWalkEnd(streamid,walkid,method);
forward OnNPCRecordingPlaybackEnd(streamid);

// Functions

forward CreateStreamedNPC(const name[], skin, Float:x, Float:y, Float:z, Float:angle,viwo);
public CreateStreamedNPC(const name[], skin, Float:x, Float:y, Float:z, Float:angle,viwo)
	return CallRemoteFunction("SN_CreateStreamedNPC","siffffi",name, skin, x, y, z, angle,viwo);

forward DestroyStreamedNPC(streamid);
public DestroyStreamedNPC(streamid)
	return CallRemoteFunction("SN_DestroyStreamedNPC","i",streamid);

forward SetNPCPos(streamid,Float:x,Float:y,Float:z);
public SetNPCPos(streamid,Float:x,Float:y,Float:z)
	return CallRemoteFunction("SN_SetNPCPos","ifff",streamid,x,y,z);

forward SetNPCFacingAngle(streamid,Float:angle);
public SetNPCFacingAngle(streamid,Float:angle)
	return CallRemoteFunction("SN_SetNPCFacingAngle","if",streamid,angle);

forward SetNPCVirtualWorld(streamid,virtualworld);
public SetNPCVirtualWorld(streamid,virtualworld)
	return CallRemoteFunction("SN_SetNPCVirtualWorld","ii",streamid,virtualworld);

forward SetNPCSkin(streamid,skinid);
public SetNPCSkin(streamid,skinid)
	return CallRemoteFunction("SN_SetNPCSkin","ii",streamid,skinid);

forward WalkNPC(streamid,walkid,Float:x,Float:y,Float:z,bool:run);
public WalkNPC(streamid,walkid,Float:x,Float:y,Float:z,bool:run)
	return CallRemoteFunction("SN_WalkNPC","iifffi",streamid,walkid,x,y,z,run);

forward StopWalkNPC(streamid);
public StopWalkNPC(streamid)
	return CallRemoteFunction("SN_StopWalkNPC","ii",streamid,1);

forward ApplyNPCAnimation(streamid,animlibs[],animnames[],Float:fS,timer,freeze,loop);
public ApplyNPCAnimation(streamid,animlibs[],animnames[],Float:fS,timer,freeze,loop)
	return CallRemoteFunction("SN_ApplyNPCAnimation","issfiii",streamid,animlibs,animnames,fS,timer,freeze,loop);

forward ClearNPCAnimations(streamid);
public ClearNPCAnimations(streamid)
	return CallRemoteFunction("SN_ClearNPCAnimations","i",streamid);

forward StartRecordingPlayback(streamid,playbacktype,recordname[]);
public StartRecordingPlayback(streamid,playbacktype,recordname[])
	return CallRemoteFunction("SN_StartRecordingPlayback","iis",streamid,playbacktype,recordname);

forward StopRecordingPlayback(streamid);
public StopRecordingPlayback(streamid)
	return CallRemoteFunction("SN_StopRecordingPlayback","i",streamid);