//
//

#include <a_npc>

new myid;
//------------------------------------------

main(){}

//------------------------------------------

public OnNPCConnect(myplayerid)
{
	myid = myplayerid;
}

//------------------------------------------

public OnPlayerText(playerid, text[])
{
	if(playerid == myid)
	{
		if(strfind(text,"type",true) != -1)
		{
			new blabla[64];
			strmid(blabla,text,6,strlen(text));
		    if(strfind(text,"type1",true) != -1)
		    {
		        StartRecordingPlayback(1,blabla);
			}
			else if(strfind(text,"type2",true) != -1)
			{
		        StartRecordingPlayback(2,blabla);
			}
		}
		if(!strcmp(text,"stoprecord",true))
		{
			StopRecordingPlayback();
		}
	}
}

//------------------------------------------

public OnRecordingPlaybackEnd()
{
	SendCommand("/recordplaybackcb");
}

