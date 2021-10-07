// Credits
// sal#3261 -- main
// @Shrugtal -- score ui
// everyone else -- advice
// new locations taken from chinese version and NorwegianFace Skyhook added
																   



global function Sh_CustomTDM_Init
global function NewLocationSettings
global function NewLocPair
global function NewWeaponKit
global function Spectator_GetReplayIsEnabled
global function Spectator_GetReplayDelay
global function Deathmatch_GetRespawnDelay
global function Equipment_GetDefaultShieldHP
global function Deathmatch_GetOOBDamagePercent
global function Deathmatch_GetVotingTime
global function CMD_GetTGiveEnabled

global function Deathmatch_GetIntroCutsceneNumSpawns           
global function Deathmatch_GetIntroCutsceneSpawnDuration        
global function Deathmatch_GetIntroSpawnSpeed        


#if SERVER
global function Equipment_GetRespawnKitEnabled
global function Equipment_GetRespawnKit_PrimaryWeapon
global function Equipment_GetRespawnKit_SecondaryWeapon
global function Equipment_GetRespawnKit_Tactical
global function Equipment_GetRespawnKit_Ultimate
#endif


global const NO_CHOICES = 2
global const SCORE_GOAL_TO_WIN = 100

global enum eTDMAnnounce
{
	NONE = 0
	WAITING_FOR_PLAYERS = 1
	ROUND_START = 2
	VOTING_PHASE = 3
	MAP_FLYOVER = 4
	IN_PROGRESS = 5
}

global struct LocPair
{
    vector origin = <0, 0, 0>
    vector angles = <0, 0, 0>
}

global struct LocationSettings 
{
    string name
    array<LocPair> spawns
    vector cinematicCameraOffset
}

global struct WeaponKit
{
    string weapon
    array<string> mods
}
struct {
    LocationSettings &selectedLocation
    array choices
    array<LocationSettings> locationSettings
    var scoreRui

} file;




void function Sh_CustomTDM_Init() 
{


    // Map locations

    switch(GetMapName())
    {
   case "mp_rr_canyonlands_staging":
        Shared_RegisterLocation(
            NewLocationSettings(
                "Firing Range",
                [
                    //Top Floor
                    NewLocPair(<29351, -8106, -15794>, <4, 45, 0>),
                    NewLocPair(<32678, -8106, -15794>, <4, 135, 0>),
                    NewLocPair(<29351, -4780, -15794>, <4, -45, 0>),
                    NewLocPair(<32678, -4780, -15794>, <4, -135, 0>),

                    //Bottom Floor
                    NewLocPair(<29351, -8106, -16073>, <4, 45, 0>),
                    NewLocPair(<32678, -8106, -16073>, <4, 135, 0>),
                    NewLocPair(<29351, -4780, -16073>, <4, -45, 0>),
                    NewLocPair(<32678, -4780, -16073>, <4, -135, 0>),

                    //Other
                    NewLocPair(<32682, -6574, -15794>, <0, 180, 0>),
                    NewLocPair(<29340, -6318, -15794>, <0, 0, 0>),
                    NewLocPair(<31138, -4778, -15794>, <0, -90, 0>),
                    NewLocPair(<30882, -8116, -15794>, <0, 90, 0>),
                ],
                <0, 0, 3000>
            )
        )
        break

case "mp_rr_canyonlands_mu1":
case "mp_rr_canyonlands_mu1_night":
case "mp_rr_canyonlands_64k_x_64k":									//possible new locations: KC-Artillery, KC-Wetlands either split into 1 or 2 small or 1 large, KC-The Farm (small), KC2-Hillside Outpost (small), KC-Watchtower North (small), KC-Watchtower South (small), KC-Goldtown (small),KC-High Desert, KC-300 Gate (small), KC-Hilltop (small), KC-River Center, KC-Crossroads (small), KC-South Settlement aka PWNtown (small), KC-East Settlement aka station near Market, KC-River's End 1 2 and 3, KC-Treatment Town (small), KC-Landing Pad aka Gas Station, 
		Shared_RegisterLocation(
            NewLocationSettings(
                "Singh Labs",												//should have different name on original KC map and also boundary adjusted maybe The Shattered Forest or something
                [
                    NewLocPair(<27576, 8062, 2910>, <0, -115, 0>),
					NewLocPair(<24545, 2387, 4100>, <0, -7, 0>),
                    NewLocPair(<25924, 2161, 3848>, <0, -9, 0>),
                    NewLocPair(<28818, 2590, 3798>, <0, 117, 0>)
                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation(
            NewLocationSettings(
                "Gaunlet",											//should be renamed to West Settlement on original KC map and also boundary adjusted
                [
                    NewLocPair(<-21271, -15275, 2781>, <0, 90, 0>),
                    NewLocPair(<-22952, -13304, 2718>, <0, 5, 0>),
                    NewLocPair(<-22467, -9567, 2949>, <0, -85, 0>),
                    NewLocPair(<-18494, -10427, 2825>, <0, -155, 0>)
                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation(
            NewLocationSettings(
                "Containment",										//should be renamed to Cascades on original KC map and also boundary adjusted
                [
                    NewLocPair(<-7291, 19547, 2978>, <0, -65, 0>),
                    NewLocPair(<-3906, 19557, 2733>, <0, -123, 0>),
                    NewLocPair(<-3084, 16315, 2566>, <0, 144, 0>),
                    NewLocPair(<-6517, 15833, 2911>, <0, 51, 0>)
                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation(
            NewLocationSettings(
                "Where there is always teamfight",
                [
                    NewLocPair(<11242, 8591, 4630>, <0, 0, 0>),
                    NewLocPair(<6657, 12189, 5066>, <0, -90, 0>),
                    NewLocPair(<7540, 8620, 5374>, <0, 89, 0>),
                    NewLocPair(<13599, 7838, 4944>, <0, 150, 0>)
                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation( 
			NewLocationSettings(
                "Cage",
                [
                    NewLocPair(<15604, -1068, 5833>, <0, -126, 0>),
                    NewLocPair(<18826, -4314, 5032>, <0, 173, 0>),
                    NewLocPair(<19946, 32, 4960>, <0, -168, 0>),
                    NewLocPair(<12335, -1446, 3984>, <0, 2, 0>)
                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation(
            NewLocationSettings(
                "Repulsor",									//boundary in serious need of adjustment; way too big. also add Hydro Dam as new area and maybe just the two bridges between Repulsor and Hydro could be interesting as a new location
                [
                    NewLocPair(<28095, -16983, 4786>, <0, 140, 0>),
                    NewLocPair(<29475, -12237, 5769>, <0, -157, 0>),
                    NewLocPair(<20567, -13551, 4821>, <0, -39, 0>),
                    NewLocPair(<22026, -17661, 5789>, <0, 21, 0>),
					NewLocPair(<26036, -17590, 5694>, <0, 90, 0>),
                    NewLocPair(<26670, -16729, 4926>, <0, -180, 0>),
                    NewLocPair(<27784, -16166, 5046>, <0, -180, 0>),
                    NewLocPair(<27133, -16074, 5414>, <0, -90, 0>),
                    NewLocPair(<27051, -14200, 5582>, <0, -90, 0>)
                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation(
            NewLocationSettings(
                "Swamps",
                [
                    NewLocPair(<37886, -4012, 3300>, <0, 167, 0>),
                    NewLocPair(<34392, -5974, 3017>, <0, 51, 0>),
                    NewLocPair(<29457, -2989, 2895>, <0, -17, 0>),
                    NewLocPair(<34582, 2300, 2998>, <0, -92, 0>),
					NewLocPair(<35757, 3256, 3290>, <0, -90, 0>),
                    NewLocPair(<36422, 3109, 3294>, <0, -165, 0>),
                    NewLocPair(<34965, 1718, 3529>, <0, 45, 0>),
                    NewLocPair(<32654, -1552, 3228>, <0, -90, 0>)

                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation(
            NewLocationSettings(
                "Interstellar Relay",
                [
                    //North Relay Building
                    NewLocPair(<26420, 31700, 4790>, <0, -90, 0>),
                    
                    //West Relay Building
                        //North Spawn
                        NewLocPair(<29260, 26245, 4210>, <0, 45, 0>),
                        //South Spawn
                        NewLocPair(<29255, 24360, 4210>, <0, 0, 0>),
                    
                    //North West Cliff Building
                    NewLocPair(<24445, 28970, 4340>, <0, -90, 0>),
                    
                    //North East Cliff Building
                    NewLocPair(<27735, 27880, 4370>, <0, 180, 0>),
                    
                    //South East Cliff Building
                    NewLocPair(<25325, 25725, 4270>, <0, 0, 0>),
                    
                    //South West Cliff Building
                    NewLocPair(<27675, 25745, 4370>, <0, 0, 0>),
                    
                    //West Cliff Building
                    NewLocPair(<24375, 27050, 4325>, <0, 180, 0>),
                    
                    //North River Building
                    NewLocPair(<24000, 23650, 4050>, <0, 135, 0>),
                    
                    //South River Building
                    NewLocPair(<23935, 22080, 4200>, <0, 15, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Slum Lakes",
                [                   
                    //East Huge Building
                        //Inside
                        NewLocPair(<-20060, 23800, 2655>, <0, 110, 0>),
                        //Balcony
                        NewLocPair(<-20245, 24475, 2810>, <0, -160, 0>),
                    
                    //West Huge Building
                        //Inside
                        NewLocPair(<-25650, 22025, 2270>, <0, 20, 0>),
                        //Rooftop
                        NewLocPair(<-25550, 21635, 2590>, <0, 20, 0>),
                        
                    //North West Tiny Building
                    NewLocPair(<-25030, 24670, 2410>, <0, -75, 0>),
                    
                    //North Big Building
                    NewLocPair(<-23125, 25320, 2410>, <0, -20, 0>),
                    
                    //South Long Building
                    NewLocPair(<-21925, 21120, 2390>, <0, 180, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Little Town",
                [
                    NewLocPair(<-30190, 12473, 3186>, <0, -90, 0>),
                    NewLocPair(<-28773, 11228, 3210>, <0, 180, 0>),
                    NewLocPair(<-29802, 9886, 3217>, <0, 90, 0>),
                    NewLocPair(<-30895, 10733, 3202>, <0, 0, 0>)
                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation(
            NewLocationSettings(
                "Skull Town",
                [
                    NewLocPair(<-9320, -13528, 3167>, <0, -100, 0>),
                    NewLocPair(<-7544, -13240, 3161>, <0, -115, 0>),
                    NewLocPair(<-10250, -18320, 3323>, <0, 100, 0>),
                    NewLocPair(<-13261, -18100, 3337>, <0, 20, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Market",
                [
                    NewLocPair(<-110, -9977, 2987>, <0, 0, 0>),
                    NewLocPair(<-1605, -10300, 3053>, <0, -100, 0>),
                    NewLocPair(<4600, -11450, 2950>, <0, 180, 0>),
                    NewLocPair(<3150, -11153, 3053>, <0, 100, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Runoff",
                [
                    NewLocPair(<-23380, 9634, 3371>, <0, 90, 0>),
                    NewLocPair(<-24917, 11273, 3085>, <0, 0, 0>),
                    NewLocPair(<-23614, 13605, 3347>, <0, -90, 0>),
                    NewLocPair(<-24697, 12631, 3085>, <0, 0, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Thunderdome",
                [
                    NewLocPair(<-20216, -21612, 3191>, <0, -67, 0>),
                    NewLocPair(<-16035, -20591, 3232>, <0, -133, 0>),
                    NewLocPair(<-16584, -24859, 2642>, <0, 165, 0>),
                    NewLocPair(<-19019, -26209, 2640>, <0, 65, 0>)
                ],
                <0, 0, 2000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Water Treatment",
                [
                    NewLocPair(<5583, -30000, 3070>, <0, 0, 0>),
                    NewLocPair(<7544, -29035, 3061>, <0, 130, 0>),
                    NewLocPair(<10091, -30000, 3070>, <0, 180, 0>),
                    NewLocPair(<8487, -28838, 3061>, <0, -45, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "The Pit",
                [
                    NewLocPair(<-18558, 13823, 3605>, <0, 20, 0>),
                    NewLocPair(<-16514, 16184, 3772>, <0, -77, 0>),
                    NewLocPair(<-13826, 15325, 3749>, <0, 160, 0>),
                    NewLocPair(<-16160, 14273, 3770>, <0, 101, 0>)
                ],
                <0, 0, 7000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Airbase",
                [
                    NewLocPair(<-24140, -4510, 2583>, <0, 90, 0>),
                    NewLocPair(<-28675, 612, 2600>, <0, 18, 0>),
                    NewLocPair(<-24688, 1316, 2583>, <0, 180, 0>),
                    NewLocPair(<-26492, -5197, 2574>, <0, 50, 0>)
                ],
                <0, 0, 3000>
            )
        )
break
case "mp_rr_canyonlands_64k_x_64k":
        Shared_RegisterLocation(
            NewLocationSettings(
                "Interstellar Relay",
                [
                    NewLocPair(<26420, 31700, 4790>, <0, -90, 0>),
                    NewLocPair(<29260, 26245, 4210>, <0, 45, 0>),
                    NewLocPair(<29255, 24360, 4210>, <0, 0, 0>),
                    NewLocPair(<24445, 28970, 4340>, <0, -90, 0>),
                    NewLocPair(<27735, 27880, 4370>, <0, 180, 0>),
                    NewLocPair(<25325, 25725, 4270>, <0, 0, 0>),
                    NewLocPair(<27675, 25745, 4370>, <0, 0, 0>),
                    NewLocPair(<24375, 27050, 4325>, <0, 180, 0>),
                    NewLocPair(<24000, 23650, 4050>, <0, 135, 0>),
                    NewLocPair(<23935, 22080, 4200>, <0, 15, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Slum Lakes",
                [                   
                    NewLocPair(<-20060, 23800, 2655>, <0, 110, 0>),
                    NewLocPair(<-20245, 24475, 2810>, <0, -160, 0>),
                    NewLocPair(<-25650, 22025, 2270>, <0, 20, 0>),
                    NewLocPair(<-25550, 21635, 2590>, <0, 20, 0>),
                    NewLocPair(<-25030, 24670, 2410>, <0, -75, 0>),
                    NewLocPair(<-23125, 25320, 2410>, <0, -20, 0>),
                    NewLocPair(<-21925, 21120, 2390>, <0, 180, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Little Town",
                [
                    NewLocPair(<-30190, 12473, 3186>, <0, -90, 0>),
                    NewLocPair(<-28773, 11228, 3210>, <0, 180, 0>),
                    NewLocPair(<-29802, 9886, 3217>, <0, 90, 0>),
                    NewLocPair(<-30895, 10733, 3202>, <0, 0, 0>)
                ],
                <0, 0, 3000>
            )
        )
		Shared_RegisterLocation(
            NewLocationSettings(
                "Skull Town",
                [
                    NewLocPair(<-9320, -13528, 3167>, <0, -100, 0>),
                    NewLocPair(<-7544, -13240, 3161>, <0, -115, 0>),
                    NewLocPair(<-10250, -18320, 3323>, <0, 100, 0>),
                    NewLocPair(<-13261, -18100, 3337>, <0, 20, 0>)
                ],
                <0, 0, 3000>
            )
        )  
        Shared_RegisterLocation(
            NewLocationSettings(
                "Market",
                [
                    NewLocPair(<-110, -9977, 2987>, <0, 0, 0>),
                    NewLocPair(<-1605, -10300, 3053>, <0, -100, 0>),
                    NewLocPair(<4600, -11450, 2950>, <0, 180, 0>),
                    NewLocPair(<3150, -11153, 3053>, <0, 100, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Runoff",
                [
                    NewLocPair(<-23380, 9634, 3371>, <0, 90, 0>),
                    NewLocPair(<-24917, 11273, 3085>, <0, 0, 0>),
                    NewLocPair(<-23614, 13605, 3347>, <0, -90, 0>),
                    NewLocPair(<-24697, 12631, 3085>, <0, 0, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Thunderdome",
                [
                    NewLocPair(<-20216, -21612, 3191>, <0, -67, 0>),
                    NewLocPair(<-16035, -20591, 3232>, <0, -133, 0>),
                    NewLocPair(<-16584, -24859, 2642>, <0, 165, 0>),
                    NewLocPair(<-19019, -26209, 2640>, <0, 65, 0>)
                ],
                <0, 0, 2000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Water Treatment",
                [
                    NewLocPair(<5583, -30000, 3070>, <0, 0, 0>),
                    NewLocPair(<7544, -29035, 3061>, <0, 130, 0>),
                    NewLocPair(<10091, -30000, 3070>, <0, 180, 0>),
                    NewLocPair(<8487, -28838, 3061>, <0, -45, 0>)
                ],
                <0, 0, 3000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "The Pit",
                [
                    NewLocPair(<-18558, 13823, 3605>, <0, 20, 0>),
                    NewLocPair(<-16514, 16184, 3772>, <0, -77, 0>),
                    NewLocPair(<-13826, 15325, 3749>, <0, 160, 0>),
                    NewLocPair(<-16160, 14273, 3770>, <0, 101, 0>)
                ],
                <0, 0, 7000>
            )
        )
        Shared_RegisterLocation(
            NewLocationSettings(
                "Airbase",
                [
                    NewLocPair(<-24140, -4510, 2583>, <0, 90, 0>),
                    NewLocPair(<-28675, 612, 2600>, <0, 18, 0>),
                    NewLocPair(<-24688, 1316, 2583>, <0, 180, 0>),
                    NewLocPair(<-26492, -5197, 2574>, <0, 50, 0>)
                ],
                <0, 0, 3000>
            )
        )

		Shared_RegisterLocation(
            NewLocationSettings(
                "Repulsor",
                [
                    NewLocPair(<28095, -16983, 4786>, <0, 140, 0>),
                    NewLocPair(<29475, -12237, 5769>, <0, -157, 0>),
                    NewLocPair(<20567, -13551, 4821>, <0, -39, 0>),
                    NewLocPair(<22026, -17661, 5789>, <0, 21, 0>),
					NewLocPair(<26036, -17590, 5694>, <0, 90, 0>),
                      NewLocPair(<26670, -16729, 4926>, <0, -180, 0>),
                      NewLocPair(<27784, -16166, 5046>, <0, -180, 0>),
                      NewLocPair(<27133, -16074, 5414>, <0, -90, 0>)
                ],
                <0, 0, 3000>
            )
        )
		
		Shared_RegisterLocation(
            NewLocationSettings(
                "Swamps",
                [
                    NewLocPair(<37886, -4012, 3300>, <0, 167, 0>),
                    NewLocPair(<34392, -5974, 3017>, <0, 51, 0>),
                    NewLocPair(<29457, -2989, 2895>, <0, -17, 0>),
                    NewLocPair(<34582, 2300, 2998>, <0, -92, 0>),
					NewLocPair(<35757, 3256, 3290>, <0, -90, 0>),
                    NewLocPair(<36422, 3109, 3294>, <0, -165, 0>),
                    NewLocPair(<34965, 1718, 3529>, <0, 45, 0>),
                    NewLocPair(<32654, -1552, 3228>, <0, -90, 0>)
                ],
                <0, 0, 3000>
            )
        )
break
case "mp_rr_desertlands_64k_x_64k":
case "mp_rr_desertlands_64k_x_64k_nx":
			Shared_RegisterLocation(
                NewLocationSettings(
                    "TTV Building",
                    [
                        NewLocPair(<11393, 5477, -4289>, <0, 90, 0>),
                        NewLocPair(<12027, 7121, -4290>, <0, -120, 0>),
                        NewLocPair(<8105, 6156, -4300>, <0, -45, 0>),
                        NewLocPair(<7965.0, 5976.0, -4266.0>, <0, -135, 0>),
                        NewLocPair(<9420, 5528, -4236>, <0, 90, 0>),
                        NewLocPair(<9862, 5561, -3832>, <0, 180, 0>),
                        NewLocPair(<9800, 5347, -3507>, <0, 134, 0>),
                        NewLocPair(<8277, 6304, -3940>, <0, 0, 0>),
                        NewLocPair(<8186, 5513, -3828>, <0, 0, 0>),
                        NewLocPair(<8243, 4537, -4235>, <-13, 32, 0>),
                        NewLocPair(<10176, 4245, -4300>, <0, 100, 0>),
                        NewLocPair(<11700, 6207, -4435>, <-10, 90, 0>),
                        NewLocPair(<11181, 5862, -3900>, <0, -180, 0>),
                        NewLocPair(<10410, 5211, -4243>, <0, -90, 0>),
                        NewLocPair(<9043, 5866, -4171>, <0, 90, 0>),
                        NewLocPair(<10107, 3843, -4000>, <0, 90, 0>),
                        NewLocPair(<11210, 4164, -4235>, <0, 90, 0>)
                    ],
                    <0, 0, 3000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "TTV Building 2",
                    [
                        NewLocPair(<1313, 4450, -2990>, <0, 50, 0>),
                        NewLocPair(<2300, 6571, -4490>, <0, -96, 0>),
						NewLocPair(<2617, 4668, -4250>, <0, 85, 0>),
                        NewLocPair(<1200, 4471, -4150>, <0, 50, 0>)
                    ],
                    <0, 0, 2000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "TTV Building 3",
                    [
                        NewLocPair(<6706, 3162, -4114>, <0, 90, 0>),
                        NewLocPair(<6475, 6338, -4191>, <0, -93, 0>),
                        NewLocPair(<4626, 5887, -4132>, <0, -28, 0>),
						NewLocPair(<4962, 3664, -4011>, <0, 29, 0>),
						NewLocPair(<4213, 4829, -4155>, <0, -4, 0>)
                    ],
                    <0, 0, 2000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Capitol Buildings",
                    [
                        NewLocPair(<1714, 9650, -4019>, <0, 93, 0>),
                        NewLocPair(<2850, 13396, -4011>, <0, -98, 0>),
						NewLocPair(<2239, 12952, -3064>, <0, -92, 0>),
						NewLocPair(<2508, 10416, -4027>, <0, 178, 0>)
                    ],
                    <0, 0, 1000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Little Town 2",
                    [
                        NewLocPair(<-27219, -24393, -4497>, <0, 87, 0>),
                        NewLocPair(<-26483, -28042, -4209>, <0, 122, 0>),
                        NewLocPair(<-25174, -26091, -4550>, <0, 177, 0>),
						NewLocPair(<-29512, -25863, -4462>, <0, 3, 0>),
						NewLocPair(<-28380, -28984, -4102>, <0, 54, 0>)
                    ],
                    <0, 0, 2000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Little Town",
                    [
                        NewLocPair(<22857, 3449, -4050>, <0, -157, 0>),
                        NewLocPair(<19559, 232, -4035>, <0, 33, 0>),
                        NewLocPair(<19400, 4384, -4027>, <0, -35, 0>)
                    ],
                    <0, 0, 2000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Dome",
                    [
                        NewLocPair(<19351, -41456, -2192>, <0, 96, 0>),
                        NewLocPair(<22925, -37060, -2169>, <0, -156, 0>),
                        NewLocPair(<19772, -34549, -2232>, <0, -137, 0>),
						NewLocPair(<17010, -37125, -2129>, <0, 81, 0>),
						NewLocPair(<15223, -40222, -1998>, <0, 86, 0>)
                    ],
                    <0, 0, 2000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Overlook",
                    [
                        NewLocPair(<32774, 6031, -3239>, <0, 117, 0>),
                        NewLocPair(<28381, 8963, -3224>, <0, 48, 0>),
                        NewLocPair(<26327, 11857, -2477>, <0, -43, 0>),
						NewLocPair(<27303, 14528, -3047>, <0, -42, 0>)
                    ],
                    <0, 0, 2000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Space Elevator",
                    [
                        NewLocPair(<-12286, 26037, -4012>, <0, -116, 0>),
                        NewLocPair(<-12318, 28447, -3975>, <0, -122, 0>),
                        NewLocPair(<-14373, 27785, -3961>, <0, -25, 0>),
						NewLocPair(<-13858, 27985, -1958>, <0, -46, 0>),
						NewLocPair(<-11638, 26123, -3983>, <0, 137, 0>)
                    ],
                    <0, 0, 2000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Epicenter",
                    [
                        NewLocPair(<8712, 23164, -3944>, <0, -49, 0>),
                        NewLocPair(<14000, 21690, -3969>, <0, -130, 0>),
                        NewLocPair(<10377, 17994, -4236>, <0, -120, 0>),
						NewLocPair(<13100, 18138, -4856>, <0, 120, 0>)

                    ],
                    <0, 0, 2000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Refinery",
                    [
                        NewLocPair(<22970, 27159, -4612>, <0, 135, 0>),
                        NewLocPair(<20430, 26481, -4200>, <0, 135, 0>),
                        NewLocPair(<19142, 30982, -4612>, <0, -45, 0>),
                        NewLocPair(<18285, 28602, -4200>, <0, -45, 0>),
                        NewLocPair(<19228, 25592, -4821>, <0, 135, 0>),
                        NewLocPair(<19495, 29283, -4821>, <0, -45, 0>),
                        NewLocPair(<18470, 28330, -4370>, <0, 135, 0>),
                        NewLocPair(<18461, 28405, -4199>, <0, 45, 0>),
                        NewLocPair(<18284, 28492, -3992>, <0, -45, 0>), 
                        NewLocPair(<19428, 27190, -4140>, <0, -45, 0>),
                        NewLocPair(<20435, 26254, -4139>, <0, -175, 0>),
                        NewLocPair(<20222, 26549, -4316>, <0, 135, 0>),
                        NewLocPair(<19444, 25605, -4602>, <0, 45, 0>),
                        NewLocPair(<21751, 29980, -4226>, <0, -135, 0>),
                        NewLocPair(<17570, 26915, -4637>, <0, -90, 0>),
                        NewLocPair(<16382, 28296, -4588>, <0, -45, 0>),
                        NewLocPair(<16618, 28848, -4451>, <0, 40, 0>)
                    ],
                    <0, 0, 6500>
                )
            )
            Shared_RegisterLocation(
                NewLocationSettings(
                    "Sorting Factory",
                    [
                        NewLocPair(<9213, -22942, -3571>, <0, -120, 0>),
                        NewLocPair(<7825, -24577, -3547>, <0, -165, 0>),
                        NewLocPair(<5846, -25513, -3523>, <0, 180, 0>),
                        NewLocPair(<4422, -25937, -3571>, <0, 90, 0>),
                        NewLocPair(<4056, -25017, -3571>, <0, -170, 0>),
                        NewLocPair(<2050, -25267, -3650>, <-5, 45, 0>),
                        NewLocPair(<2068, -25171, -3318>, <15, 45, 0>),
                        NewLocPair(<2197, -22687, -3572>, <-3, -90, 0>),
                        NewLocPair(<7081, -23051, -3667>, <0, 45, 0>),
                        NewLocPair(<8922, -22135, -3119>, <0, 180, 0>),
                        NewLocPair(<5436, -22436, -3188>, <0, 90, 0>),
                        NewLocPair(<4254, -23031, -3522>, <0, 45, 0>),
                        NewLocPair(<8211, -21413, -3700>, <0, -140, 0>),
                        NewLocPair(<4277, -24101, -3571>, <0, -60, 0>)
                    ],
                    <0, 0, 3000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Lava Fissure",
                    [
                        NewLocPair(<-26550, 13746, -3048>, <0, -134, 0>),
						NewLocPair(<-28877, 12943, -3109>, <0, -88.70, 0>),
                        NewLocPair(<-29881, 9168, -2905>, <-1.87, -2.11, 0>),
						NewLocPair(<-27590, 9279, -3109>, <0, 90, 0>)
                    ],
                    <0, 0, 2500>
                )
            )
            Shared_RegisterLocation(
                NewLocationSettings(
                    "Lava City",
                    [
                        NewLocPair(<22663, -28134, -2706>, <0, 40, 0>),
                        NewLocPair(<22844, -28222, -3030>, <0, 90, 0>),
                        NewLocPair(<22687, -27605, -3434>, <0, -90, 0>),
                        NewLocPair(<22610, -26999, -2949>, <0, 90, 0>),
                        NewLocPair(<22607, -26018, -2749>, <0, -90, 0>),
                        NewLocPair(<22925, -25792, -3500>, <0, -120, 0>),
                        NewLocPair(<24235, -27378, -3305>, <0, -100, 0>),
                        NewLocPair(<24345, -28872, -3433>, <0, -144, 0>),
                        NewLocPair(<24446, -28628, -3252>, <13, 0, 0>),
                        NewLocPair(<23931, -28043, -3265>, <0, 0, 0>),
                        NewLocPair(<27399, -28588, -3721>, <0, 130, 0>),
                        NewLocPair(<26610, -25784, -3400>, <0, -90, 0>),
                        NewLocPair(<26757, -26639, -3673>, <-10, 90, 0>),
                        NewLocPair(<26750, -26202, -3929>, <-10, -90, 0>)
                    ],
                    <0, 0, 3000>
                )
            )
            Shared_RegisterLocation(
                NewLocationSettings(
                    "Thermal Station",
                    [
                        NewLocPair(<-20091, -17683, -3984>, <0, -90, 0>),
						NewLocPair(<-22919, -20528, -4010>, <0, 0, 0>),
						NewLocPair(<-17140, -20710, -3973>, <0, -180, 0>),
                        NewLocPair(<-21054, -23399, -3850>, <0, 90, 0>),
                        NewLocPair(<-20938, -23039, -4252>, <0, 90, 0>),
                        NewLocPair(<-19361, -23083, -4252>, <0, 100, 0>),
                        NewLocPair(<-19264, -23395, -3850>, <0, 100, 0>),
                        NewLocPair(<-16756, -20711, -3982>, <0, 180, 0>),
                        NewLocPair(<-17066, -20746, -4233>, <0, 180, 0>),
                        NewLocPair(<-17113, -19622, -4269>, <10, -170, 0>),
                        NewLocPair(<-20092, -17684, -4252>, <0, -90, 0>),
                        NewLocPair(<-23069, -20567, -4214>, <-11, 146, 0>),
                        NewLocPair(<-20109, -20675, -4252>, <0, -90, 0>)
                    ],
                    <0, 0, 11000>
                )
            )
			Shared_RegisterLocation(
                NewLocationSettings(
                    "Capitol City XL",
                    [
                        NewLocPair(<8660, 5910, -4168>, <-13, 50, 0>),
                        NewLocPair(<2300, 6571, -4490>, <1.2, -96, 0>),
                        NewLocPair(<1200, 4471, -4150>, <-1.4, 50, 0>),
                        NewLocPair(<12106, 1769, -3453>, <-1.4, 126, 0>),
                        NewLocPair(<14047, 5915, -3903>, <-1.4, 174, 0>),
                        NewLocPair(<11117, 10604, -4211>, <-1.4, -112, 0>),
                        NewLocPair(<6630, 13856, -3935>, <-1.4, -90, 0>),
                        NewLocPair(<1986, 12817, -3227>, <-1.4, -91, 0>),
						NewLocPair(<5028, 10272, -3981>, <-1.4, -87, 0>),
						NewLocPair(<5412, 5449, -4145>, <-1.4, -59, 0>),
						NewLocPair(<11010, 3297, -4165>, <-1.4, 90, 0>),
                    ],
                    <0, 0, 3000>
                )
            )
//			Shared_RegisterLocation(
//                NewLocationSettings(
//	                   "Open Field",									//awful and massive location. maybe okay for snipers or some other weird gamemode
//                    [
//                        NewLocPair(<-334, 34239, -2854>, <0, -46, 0>),
//                        NewLocPair(<3470, 28739, -4242>, <0, 42, 0>),
//                        NewLocPair(<9818, 26807, -3605>, <0, 135, 0>),
//						NewLocPair(<12661, 36004, -4055>, <0, -129, 0>),
//                    ],
//                    <0, 0, 2000>
//                )
//            )
//            Shared_RegisterLocation(
//                NewLocationSettings(
//                    "SkyHook XL",										//MASSIVE AREA. Probably only good for certain gamemodes with 20+ ppl
//                    [
//                          // These are the 3 "corner" spawns, this was the best way to set the dome boundry.
//                        NewLocPair(<-7374, 26341, -3975>, <0, -45, 0>),
//                        NewLocPair(<-17001, 30130, -3945>, <0, -45, 0>),
//                        NewLocPair(<-17088, 21192, -3971>, <0, 100, 0>),
//
//                          // These are the spawns under the 4 'feet' of the central skyhook tower
//                        NewLocPair(<-11897, 27062, -4025>, <0, 0, 0>),
//                        NewLocPair(<-12918, 28075, -4025>, <0, 90, 0>),
//                        NewLocPair(<-13937, 27060, -4025>, <0, 180, 0>),
//                        NewLocPair(<-12921, 26035, -4025>, <0, -90, 0>),
//
//                         //These are just a handfull of other spawns sprinked through the map
//                        NewLocPair(<-9615, 25891, -4025>, <0, 140, 0>),
//                        NewLocPair(<-9082, 27785, -3971>, <0, -135, 0>),
//                        NewLocPair(<-9274, 29188, -3925>, <0, 15, 0>),
//                       NewLocPair(<-11753, 29596, -4070>, <0, 45, 0>),
//                        NewLocPair(<-17095, 24879, -3972>, <0, -90, 0>),
//
//                        //These are dump spawns for when the server is more full. At the start of the round players will spawn here instead of somewhere in the death feild.
//                        NewLocPair(<-13382, 27517, -681>, <0, -50, 0>),
//                        NewLocPair(<-13136, 27722, -681>, <0, -75, 0>),
//                        NewLocPair(<-12569, 27802, -681>, <0, -117, 0>),
//                        NewLocPair(<-12472, 26532, -681>, <0, 126, 0>),
//                        NewLocPair(<-12869, 26384, -681>, <0, 90, 0>),
//                        NewLocPair(<-13326, 26350, -681>, <0, 60, 0>),
//                        NewLocPair(<-13609, 26578, -681>, <0, 35, 0>),
//                        NewLocPair(<-13822, 27188, -681>, <0, -8, 0>),
//                        
//                    ],
//                        <0, 0, 500>
//                    )
//                )
        default:
            Assert(false, "No TDM locations found for map!")
    }

    //Client Signals
    RegisterSignal( "CloseScoreRUI" )
    
}

LocPair function NewLocPair(vector origin, vector angles)
{
    LocPair locPair
    locPair.origin = origin
    locPair.angles = angles

    return locPair
}

LocationSettings function NewLocationSettings(string name, array<LocPair> spawns, vector cinematicCameraOffset)
{
    LocationSettings locationSettings
    locationSettings.name = name
    locationSettings.spawns = spawns
    locationSettings.cinematicCameraOffset = cinematicCameraOffset

    return locationSettings
}

WeaponKit function NewWeaponKit(string weapon, array<string> mods)
{
    WeaponKit weaponKit
    weaponKit.weapon = weapon
    weaponKit.mods = mods
    
    return weaponKit
}																  

void function Shared_RegisterLocation(LocationSettings locationSettings)
{
    #if SERVER
    _RegisterLocation(locationSettings)
    #endif


    #if CLIENT
    Cl_RegisterLocation(locationSettings)
    #endif


}


// Playlist GET

float function Deathmatch_GetIntroCutsceneNumSpawns()                { return GetCurrentPlaylistVarFloat("intro_cutscene_num_spawns", 1)}
float function Deathmatch_GetIntroCutsceneSpawnDuration()            { return GetCurrentPlaylistVarFloat("intro_cutscene_spawn_duration", 3)}
float function Deathmatch_GetIntroSpawnSpeed()                       { return GetCurrentPlaylistVarFloat("intro_cutscene_spawn_speed", 40)}
bool function Spectator_GetReplayIsEnabled()                         { return GetCurrentPlaylistVarBool("replay_enabled", false ) } 
float function Spectator_GetReplayDelay()                            { return GetCurrentPlaylistVarFloat("replay_delay", 5 ) } 
float function Deathmatch_GetRespawnDelay()                          { return GetCurrentPlaylistVarFloat("respawn_delay", 8) }
float function Equipment_GetDefaultShieldHP()                        { return GetCurrentPlaylistVarFloat("default_shield_hp", 100) }
float function Deathmatch_GetOOBDamagePercent()                      { return GetCurrentPlaylistVarFloat("oob_damage_percent", 25) }
float function Deathmatch_GetVotingTime()                            { return GetCurrentPlaylistVarFloat("voting_time", 5) }
bool function CMD_GetTGiveEnabled()                                  { return GetCurrentPlaylistVarBool("tgive_enabled", true) }
      
#if SERVER      
bool function Equipment_GetRespawnKitEnabled()                       { return GetCurrentPlaylistVarBool("respawn_kit_enabled", false) }

StoredWeapon function Equipment_GetRespawnKit_PrimaryWeapon()
{ 
    return Equipment_GetRespawnKit_Weapon(
        GetCurrentPlaylistVarString("respawn_kit_primary_weapon", "~~none~~"),
        eStoredWeaponType.main,
        WEAPON_INVENTORY_SLOT_PRIMARY_0
    ) 
}
StoredWeapon function Equipment_GetRespawnKit_SecondaryWeapon()
{ 
    return Equipment_GetRespawnKit_Weapon(
        GetCurrentPlaylistVarString("respawn_kit_secondary_weapon", "~~none~~"),
        eStoredWeaponType.main,
        WEAPON_INVENTORY_SLOT_PRIMARY_1
    )
}
StoredWeapon function Equipment_GetRespawnKit_Tactical()
{ 
    return Equipment_GetRespawnKit_Weapon(
        GetCurrentPlaylistVarString("respawn_kit_tactical", "~~none~~"),
        eStoredWeaponType.offhand,
        OFFHAND_TACTICAL
    )
}
StoredWeapon function Equipment_GetRespawnKit_Ultimate()
{ 
    return Equipment_GetRespawnKit_Weapon(
        GetCurrentPlaylistVarString("respawn_kit_ultimate", "~~none~~"),
        eStoredWeaponType.offhand,
        OFFHAND_ULTIMATE
    )
}

StoredWeapon function Equipment_GetRespawnKit_Weapon(string input, int type, int index)
{
    StoredWeapon weapon
    if(input == "~~none~~") return weapon

    array<string> args = split(input, " ")

    if(args.len() == 0) return weapon

    weapon.name = args[0]
    weapon.weaponType = type
    weapon.inventoryIndex = index
    weapon.mods = args.slice(1, args.len())

    return weapon
}
#endif