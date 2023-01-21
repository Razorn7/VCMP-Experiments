/*
 convert HTML color code to RGB
 Ex: print(hexToRGB("#2e2e2e")) - {47, 47, 47}
*/
function hexToRGB(hex) {
    hex = hex.slice(1, hex.len());
    local lookup = ['0','1','2','3','4','5','6','7','8','9', 'a','b','c','d','e','f'];
    local r, g, b;
    r = lookup.find(hex.slice(0, 2)[0]) * 0x10 + lookup.find(hex.slice(0, 2)[1]);
    g = lookup.find(hex.slice(2, 4)[0]) * 0x10 + lookup.find(hex.slice(2, 4)[1]);
    b = lookup.find(hex.slice(4, 6)[0]) * 0x10 + lookup.find(hex.slice(4, 6)[1]);
	
	return { r = r, g = g, b = b }
}

// player.Kill() - kill the player
function CPlayer::Kill() {
  this.Health = 0;
}

// player.Heal() - heal the player
function CPlayer::Heal() {
  this.Health = 100;
}

// vehicle.GetRadiansAngle() - return the radians angle value of a vehicle (function not created by me)
function CVehicle::GetRadiansAngle() {
	local angle = ::asin(this.Rotation.z) * 2;
  return this.Rotation.w < 0 ? 3.14159 - angle : 6.28319 - angle;
}

/* 
 calculates the ratio given by two values
 Ex: print(CalculateRatio(14,10)) - 1.40
*/
function CalculateRatio(v1, v2) {
	return (v2 != 0 ? format("%.2f", v1.tofloat() / v2.tofloat()) : "0.00");
}

// return the closest player (function not created by me)
function GetClosestPlayer(source, max_distance = 100) {
	local int_MaxPlayers = GetMaxPlayers(), tbl_CloestPlayer = { Instance = null, Distance = max_distance };
	for (local i = 0; i < int_MaxPlayers; i++) {
		local player = FindPlayer(i);
		if (player) {
			if (player.ID != source.ID) {
				local distance = source.Pos.Distance( player.Pos );
				if( distance < tbl_CloestPlayer.Distance ) {
					tbl_CloestPlayer.Instance = player;
					tbl_CloestPlayer.Distance = distance;
				}
			}
		}
	}
	return tbl_CloestPlayer.Instance;
}

// https://developer.electricimp.com/examples/random
function rndstr(length, alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") {
    // Generate a pseudo-random string from the supplied (or default) alphabet
    if (alphabet == null || typeof alphabet != "string") alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    if (length < 1) throw "rndstr()'s length parameter requires a value greater than zero";

    local rs = "";
    for (local i = 0 ; i < length ; i++) {
        local roll = (1.0 * alphabet.len() * rand() / RAND_MAX).tointeger();
        rs = rs + alphabet.slice(roll, roll + 1);
    }
    return rs;
}

function GetDeathReason(reason) {
	switch(reason) {
		case 70:
		return "Suicide";
		break;
		case 39:
		return "Driving accident";
		break;
		case 31:
		return "Burned";
		break;
		case 14:
		return "Chocked";
		break;
		case 43:
		return "Drowned";
		break;
		case 41:
		case 51:
		return "Exploded";
		break;
		case 44:
		return "Fall";
		break;
		case "Unknown reason";
	}
}

function GetBodyPart(part)
{
	switch(part) {
		case 0:
		return "Body";
		break;
		case 1: 
		return "Torso"; 
		break;
		case 2: 
		return "Left Arm";
		break;
		case 3: 
		return "Right Arm";
		break;
		case 4: 
		return "Left Leg";
		break;
		case 5: 
		return "Right Leg";
		break;
		case 6: 
		return  "Head"; 
		break;
	}
}

function ConvertStringToVector(string) {
	local str = split(string, ",");

	return Vector(strip[0].tofloat(), strip[1].tofloat(), strip[2].tofloat());
}

function ConvertVectorToString(vector) {
	return format("(%f, %f, %f)", vector.x, vector.y, vector.z);
}
