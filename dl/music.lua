function alCmd(cmd)
	Cmd(FindObject("OpenAL"), cmd);
end

openal=EnableOpenAL();
SetName(openal, "OpenAL");
local al=FindObject("OpenAL");

alCmd("Close music");
alCmd("Open Music\\action9.ogg 0 1 music");
alCmd("Dist music 50000 50000");
alCmd("Gain music 0.5 0.5 0.5");
alCmd("Pitch music "..tostring(((random() * 0.2) + 0.9)));
alCmd("Move music 270 231 373");
alCmd("Play music");
		
ActionTrackID=random(1, 10); --//6
ExploreTrackID=random(1, 4); --//2
--MusicReadyTimeout=5;
MusicRush=0;
--MusicTimeOut=5;
Music1Volume=0;
Music1TargetVolume=0;
Music2Volume=0;
Music2TargetVolume=0;

function MusicUpdate()
	MusicTimeOut=(MusicTimeOut - DT);
	MusicRush=(MusicRush - DT);

	MusicReadyTimeout=(MusicReadyTimeout + DT);
	if (MusicReadyTimeout<2) then
		alCmd("GlobalGain "..tostring((MusicReadyTimeout / 2)));
		do return end;
		
	end
	
	local health=GetNumber(PLAYER, "health");
	local felony=GetNumber(PLAYER, "felony");
	local player_car=GetVehicle(PLAYER);
	local stolen_car=GetNumber(player_car, "stolen");
	if (player_car>0) then
		stolen_car=1;
	end
	
	if (MusicRush>20) then
		MusicRush=20;
	end
	
	if (felony>0) or (car>1) or (stolen_car==1) or (MusicRush>0) and (Music1TargetVolume==0) or (MusicTimeOut<0) then
	print("felony1 MusicTimeOut ".. MusicTimeOut .. " MusicReadyTimeout" .. MusicReadyTimeout);
	print(player_car);
	 local length=10;
		if (Music2Volume<=0) and (MENU_MUSIC>-100) then
			print("My CAR Action!");
			alCmd("Close music");
			local trackID=ActionTrackID;
			ActionTrackID=(ActionTrackID + 1);
			local trackLength={3.1,4.04,3.23,2.56,3.12,3.40,2.36,1.51,3.26,2.03};
			if (ActionTrackID>11) then
				ActionTrackID=1;
			end
			
			length=((trackLength[trackID] * 60) + 10);
			print("action:".. trackID);
			alCmd("Open Music\\action"..trackID..".ogg 0 1 music");
			
			alCmd("Dist music 50000 50000");
--My
--alCmd("Close music");
--alCmd("Open Music\\action"..trackID..".ogg 0 1 music");
--alCmd("Dist music 50000 50000");
alCmd("Gain music 0.5 0.5 0.5");
--alCmd("Pitch music "..tostring(((random() * 0.2) + 0.9)));
--alCmd("Move music 270 231 373");
alCmd("Play music");
			
			--alCmd("Gain music 0 0 0");
			--alCmd("Play music");
			Music1TargetVolume=1;
			Music1Volume=0;
		end
		
		Music2TargetVolume=0;
		MusicTimeOut=length;
		print("timeout:".. MusicTimeOut);
	end
	
	if (felony>0) or (stolen_car==1) or (MusicRush>0) or (Music1TargetVolume>0) then
	print("main killer: felony " .. felony .. " stolencar: " .. stolen_car);
	print("main killer: MusicRush " .. MusicRush .. " Music1TargetVolume: " .. Music1TargetVolume);
		Music1TargetVolume=0;
		MusicTimeOut=5;
	end
	
	if (MusicRush>0) or (MusicTimeOut<=0) then
	print("main killer: felony " .. felony .. " stolencar: " .. stolen_car);
	print("felony2 ".. MusicTimeOut ".. MusicTimeOut" .. " MusicReadyTimeout" .. MusicReadyTimeout);
	 local length=10;
		if (MENU_MUSIC>-100) then
			print("My WALKING Explore!");
			alCmd("Close music");
			local trackID=ExploreTrackID;
			ExploreTrackID=(ExploreTrackID + 1);
			if (ExploreTrackID>4) then
				ExploreTrackID=1;
			end
			
			local trackLength={2.34,3.12,2.45,3};
			length=((trackLength[trackID] * 60) + 10);
			print("explore:".. trackID);
			alCmd("Open Music\\explore"..trackID..".ogg 0 1 music");
			alCmd("Dist music 50000 50000");
			alCmd("Gain music 0.5 0.5 0.5");
			alCmd("Play music");
			Music2TargetVolume=1;
			Music2Volume=0;
		end
		
		MusicTimeOut=length;
		print("timeout:".. MusicTimeOut);
	end
	
	if (Music1Volume<Music1TargetVolume) then
		Music1Volume=(Music1Volume + (DT * 0.5));
		if (Music1Volume>Music1TargetVolume) then
			Music1Volume=Music1TargetVolume;
		end
		
	end
	
	if (Music1Volume>Music1TargetVolume) then
	print("music 1 killer Music1Volume: " .. Music1Volume .. " target: " .. Music1TargetVolume);
		Music1Volume=(Music1Volume - (DT * 0.5));
		if (Music1Volume<Music1TargetVolume) then
			Music1Volume=Music1TargetVolume;
			alCmd("Close music");
			MusicTimeOut=5;
		end
		
	end
	
	if (Music2Volume<Music2TargetVolume) then
		Music2Volume=(Music2Volume + (DT * 0.5));
		if (Music2Volume>Music2TargetVolume) then
			Music2Volume=Music2TargetVolume;
		end
		
	end
	
	if (Music2Volume>Music2TargetVolume) then
	print("music 2 killer Music1Volume: " .. Music1Volume .. " target: " .. Music1TargetVolume);
		Music2Volume=(Music2Volume - (DT * 0.5));
		if (Music2Volume<Music2TargetVolume) then
			Music2Volume=Music2TargetVolume;
			alCmd("Close music");
		end
		
	end
	
	local music_volume=(((MENU_MUSIC + 100) / 100) * 0.7);
	if (Music1Volume>0) then
		alCmd(format("Gain music %f 0 1", (Music1Volume * length)));
	end
	
	if (Music2Volume>0) then
		alCmd(format("Gain music %f 0 1", (Music2Volume * length)));
	end
	

end