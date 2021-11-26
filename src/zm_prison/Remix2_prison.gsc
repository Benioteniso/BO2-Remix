#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_utility;
#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_weap_tomahawk;
#include maps/mp/zm_alcatraz_utility;
#include maps/mp/zombies/_zm_craftables;
#include maps/mp/zombies/_zm_equipment;

main()
{
    replaceFunc( maps/mp/zm_prison::include_weapons, ::include_weapons_override );
	replaceFunc( maps/mp/zm_alcatraz_sq::setup_master_key, ::setup_master_key );
	// replaceFunc( maps/mp/zombies/_zm_weap_tomahawk::tomahawk_attack_zombies, ::tomahawk_attack_zombies_override );
	replaceFunc( maps/mp/zombies/_zm_weap_tomahawk::tomahawk_pickup_trigger, ::tomahawk_pickup_trigger );
	replaceFunc( maps/mp/zm_alcatraz_utility::wait_for_player_to_take, ::wait_for_player_to_take_override );

    level.initial_spawn_prison = true;
    level thread onplayerconnect();

	thread spawn_bench( (-1047, 8563, 1336), (0, 0, 0) ); //wardens
}

onplayerconnect()
{   
    for(;;)
    {
        level waittill("connected", player);
        player thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon("disconnect");
    self.initial_spawn_prison = true;
    
    for(;;)
    {
        self waittill("spawned_player");

        if(self.initial_spawn_prison)
		{
            self.initial_spawn_prison = true;
        }

        if(level.initial_spawn_prison)
        {
            level.initial_spawn_prison = false;

			flag_wait( "start_zombie_round_logic" );

			thread open_warden_fence();
        }
    }
}

open_warden_fence()
{
	m_lock = getent( "masterkey_lock_2", "targetname" );
	m_lock delete();
	t_warden_fence_damage = getent( "warden_fence_damage", "targetname" );
	t_warden_fence_damage delete();
	admin_powerhouse_puzzle_door_clip = getent( "admin_powerhouse_puzzle_door_clip", "targetname" );
	admin_powerhouse_puzzle_door_clip delete();
	admin_powerhouse_puzzle_door = getent( "admin_powerhouse_puzzle_door", "targetname" );
	admin_powerhouse_puzzle_door rotateyaw( 90, 0.5 );
	exploder( 2000 );
	flag_set( "generator_challenge_completed" );
	wait 0.1;
	level clientnotify( "sndWard" );
	level thread maps/mp/zombies/_zm_audio::sndmusicstingerevent( "piece_mid" );
	t_warden_fence_damage = getent( "warden_fence_damage", "targetname" );
	t_warden_fence_damage delete();
	level setclientfield( "warden_fence_down", 1 );
	array_delete( getentarray( "generator_wires", "script_noteworthy" ) );
	wait 3;
	stop_exploder( 2000 );
	wait 1;
}


include_weapons_override() //checked changed to match cerberus output
{
	include_weapon( "knife_zm", 0 );
	include_weapon( "knife_zm_alcatraz", 0 );
	include_weapon( "spoon_zm_alcatraz", 0 );
	include_weapon( "spork_zm_alcatraz", 0 );
	include_weapon( "frag_grenade_zm", 0 );
	include_weapon( "claymore_zm", 0 );
	include_weapon( "willy_pete_zm", 0 );
	include_weapon( "m1911_zm", 0 );
	include_weapon( "m1911_upgraded_zm", 0 );
	include_weapon( "judge_zm" );
	include_weapon( "judge_upgraded_zm", 0 );
	include_weapon( "beretta93r_zm", 0 );
	include_weapon( "beretta93r_upgraded_zm", 0 );
	include_weapon( "fivesevendw_zm" );
	include_weapon( "fivesevendw_upgraded_zm", 0 );
	include_weapon( "fivesevendw_zm" );
	include_weapon( "fivesevendw_upgraded_zm", 0 );
	include_weapon( "uzi_zm", 0 );
	include_weapon( "uzi_upgraded_zm", 0 );
	if ( is_classic() )
	{
		include_weapon( "thompson_zm", 0 );
		include_weapon( "870mcs_zm", 0 );
	}
	else
	{
		include_weapon( "870mcs_zm" );
		include_weapon( "thompson_zm" );
	}
	include_weapon( "thompson_upgraded_zm", 0 );
	include_weapon( "mp5k_zm", 0 );
	include_weapon( "mp5k_upgraded_zm", 0 );
	include_weapon( "pdw57_zm" );
	include_weapon( "pdw57_upgraded_zm", 0 );
	include_weapon( "870mcs_upgraded_zm", 0 );
	include_weapon( "saiga12_zm" );
	include_weapon( "saiga12_upgraded_zm", 0 );
	include_weapon( "rottweil72_zm", 0 );
	include_weapon( "rottweil72_upgraded_zm", 0 );
	include_weapon( "m14_zm", 0 );
	include_weapon( "m14_upgraded_zm", 0 );
	include_weapon( "ak47_zm" );
	include_weapon( "ak47_upgraded_zm", 0 );
	include_weapon( "tar21_zm" );
	include_weapon( "tar21_upgraded_zm", 0 );
	include_weapon( "galil_zm" );
	include_weapon( "galil_upgraded_zm", 0 );
	include_weapon( "fnfal_zm" );
	include_weapon( "fnfal_upgraded_zm", 0 );
	include_weapon( "dsr50_zm" );
	include_weapon( "dsr50_upgraded_zm", 0 );
	include_weapon( "barretm82_zm" );
	include_weapon( "barretm82_upgraded_zm", 0 );
	include_weapon( "minigun_alcatraz_zm" );
	include_weapon( "minigun_alcatraz_upgraded_zm", 0 );
	include_weapon( "lsat_zm" );
	include_weapon( "lsat_upgraded_zm", 0 );
	include_weapon( "usrpg_zm" );
	include_weapon( "usrpg_upgraded_zm", 0 );
	include_weapon( "ray_gun_zm" );
	include_weapon( "ray_gun_upgraded_zm", 0 );
	include_weapon( "bouncing_tomahawk_zm", 0 );
	include_weapon( "upgraded_tomahawk_zm", 0 );
	include_weapon( "blundergat_zm" );
	include_weapon( "blundergat_upgraded_zm", 0 );
	include_weapon( "blundersplat_zm", 0 );
	include_weapon( "blundersplat_upgraded_zm", 0 );
	level._uses_retrievable_ballisitic_knives = 1;
	include_weapon( "alcatraz_shield_zm", 0 );
	add_limited_weapon( "m1911_zm", 4 );
	add_limited_weapon( "minigun_alcatraz_zm", 1 );
	//add_limited_weapon( "blundergat_zm", 1 );
	add_limited_weapon( "ray_gun_zm", 4 );
	add_limited_weapon( "ray_gun_upgraded_zm", 4 );
	include_weapon( "tower_trap_zm", 0 );
	include_weapon( "tower_trap_upgraded_zm", 0 );
	if ( isdefined( level.raygun2_included ) && level.raygun2_included )
	{
		include_weapon( "raygun_mark2_zm" );
		include_weapon( "raygun_mark2_upgraded_zm", 0 );
		add_weapon_to_content( "raygun_mark2_zm", "dlc3" );
		add_limited_weapon( "raygun_mark2_zm", 1);
		add_limited_weapon( "raygun_mark2_upgraded_zm", 1 );
	}
}

setup_master_key()
{
	level.is_master_key_west = 0;
	setclientfield( "fake_master_key", level.is_master_key_west + 1 );
	if ( level.is_master_key_west )
	{
		level thread maps/mp/zm_alcatraz_sq::key_pulley( "west" );
		exploder( 101 );
		array_delete( getentarray( "wires_pulley_east", "script_noteworthy" ) );
	}
	else
	{
		level thread maps/mp/zm_alcatraz_sq::key_pulley( "east" );
		exploder( 100 );
		array_delete( getentarray( "wires_pulley_west", "script_noteworthy" ) );
	}
}

tomahawk_attack_zombies_override( m_tomahawk, a_zombies ) //checked changed to match cerberus output
{
	self endon( "disconnect" );

	max_attack_limit = 4;
	if ( !isDefined( a_zombies ) )
	{
		self thread tomahawk_return_player( m_tomahawk, 0 );
		return;
	}
	if ( a_zombies.size <= max_attack_limit )
	{
		n_attack_limit = a_zombies.size;
	}
	else
	{
		n_attack_limit = max_attack_limit;
	}
	for ( i = 0; i < n_attack_limit; i++ )
	{
		if ( isDefined( a_zombies[ i ] ) && isalive( a_zombies[ i ] ) )
		{
			tag = "J_Head";
			if ( a_zombies[ i ].isdog )
			{
				tag = "J_Spine1";
			}
			if ( isDefined( a_zombies[ i ].hit_by_tomahawk ) && !a_zombies[ i ].hit_by_tomahawk )
			{
				v_target = a_zombies[ i ] gettagorigin( tag );
				m_tomahawk moveto( v_target, 0.3 );
				m_tomahawk waittill( "movedone" );
				if ( isDefined( a_zombies[ i ] ) && isalive( a_zombies[ i ] ) )
				{
					if ( self.current_tactical_grenade == "upgraded_tomahawk_zm" )
					{
						playfxontag( level._effect[ "tomahawk_impact_ug" ], a_zombies[ i ], tag );
					}
					else
					{
						playfxontag( level._effect[ "tomahawk_impact" ], a_zombies[ i ], tag );
					}
					playfxontag( level._effect[ "tomahawk_fire_dot" ], a_zombies[ i ], "j_spineupper" );
					a_zombies[ i ] setclientfield( "play_tomahawk_hit_sound", 1 );
					n_tomahawk_damage = calculate_tomahawk_damage( a_zombies[ i ], m_tomahawk.n_grenade_charge_power, m_tomahawk );
					a_zombies[ i ] dodamage( n_tomahawk_damage, m_tomahawk.origin, self, m_tomahawk, "none", "MOD_GRENADE", 0, "bouncing_tomahawk_zm" );
					a_zombies[ i ].hit_by_tomahawk = 1;
					self maps/mp/zombies/_zm_score::add_to_player_score( 10 );
				}
			}
		}
		wait 0.2;
	}
	self thread tomahawk_return_player( m_tomahawk, n_attack_limit );
}

tomahawk_pickup_trigger() //checked changed to match cerberus output
{
	while ( 1 )
	{
		self waittill( "trigger", player );

		if ( isDefined( player.current_tactical_grenade ) && !issubstr( player.current_tactical_grenade, "tomahawk_zm" ) )
		{
			player takeweapon( player.current_tactical_grenade );
		}

		if ( !player hasweapon( "bouncing_tomahawk_zm" ) && !player hasweapon( "upgraded_tomahawk_zm" ) )
		{
			player.current_tomahawk_weapon = "upgraded_tomahawk_zm";

			player notify( "tomahawk_picked_up" );
			level notify( "bouncing_tomahawk_zm_aquired" );
			player notify( "player_obtained_tomahawk" );

			player.tomahawk_upgrade_kills = 99;
			player.killed_with_only_tomahawk = 1;
			player.killed_something_thq = 1;
			player notify( "tomahawk_upgraded_swap" );

			player disable_player_move_states( 1 );
			gun = self getcurrentweapon();
			player notify( "player_obtained_tomahawk" );
			player maps/mp/zombies/_zm_stats::increment_client_stat( "prison_tomahawk_acquired", 0 );
			player giveweapon( "zombie_tomahawk_flourish" );
			player thread tomahawk_update_hud_on_last_stand();
			player switchtoweapon( "zombie_tomahawk_flourish" );
			player waittill_any( "player_downed", "weapon_change_complete" );
			player takeweapon( "zombie_tomahawk_flourish" );
			player enable_player_move_states();

			player.redeemer_trigger = self;
			player setclientfieldtoplayer( "upgraded_tomahawk_in_use", 1 );

			player giveweapon( "upgraded_tomahawk_zm" );
			player switchtoweapon( gun );

		}
		wait 0.1;
	}
}

wait_for_player_to_take_override( player, str_valid_weapon )
{
	self endon( "acid_timeout" );
	player endon( "disconnect" );
	while ( 1 )
	{
		self waittill( "trigger", trigger_player );
		if ( trigger_player == player )
		{
			current_weapon = player getcurrentweapon();
			if ( !is_placeable_mine( current_weapon ) && !is_equipment( current_weapon ) )
			{
				self notify( "acid_taken" );
				player notify( "acid_taken" );
				weapon_limit = 3;
				primaries = player getweaponslistprimaries();
				if ( primaries.size >= weapon_limit )
				{
					player takeweapon( current_weapon );
				}
				str_new_weapon = undefined;
				if ( str_valid_weapon == "blundergat_zm" )
				{
					str_new_weapon = "blundersplat_zm";
				}
				else
				{
					str_new_weapon = "blundersplat_upgraded_zm";
				}
				if ( player hasweapon( "blundersplat_zm" ) )
				{
					player givemaxammo( "blundersplat_zm" );
				}
				else if ( player hasweapon( "blundersplat_upgraded_zm" ) )
				{
					player givemaxammo( "blundersplat_upgraded_zm" );
				}
				else
				{
					player giveweapon( str_new_weapon );
					player switchtoweapon( str_new_weapon );
				}
				player thread do_player_general_vox( "general", "player_recieves_blundersplat" );
				player notify( "player_obtained_acidgat" );
				player thread player_lost_blundersplat_watcher();
				return;
			}
		}
	}
}

spawn_bench( origin, angles ) //jz is the best
{
	level endon("end_game");

	bench = spawn("script_model", origin);
	bench SetModel("p6_zm_work_bench");
	bench.angles = angles;
	col = spawn("script_model", origin + (-25,0,0));
	col SetModel("collision_clip_64x64x64");
	col.angles = angles;
	shieldModel = spawn("script_model", origin + ( 0, 0, 70 ) );
	shieldModel SetModel("t6_wpn_zmb_shield_dlc2_dmg0_world");
	shieldModel.angles = ( angles + vectorScale( ( 0, 0, 0 ), 90 ) );
	trigger = spawn("trigger_radius", origin + (0,0,32), 20, 35, 70);
	trigger.targetname = "shield_trigger";
	trigger.angles = angles;
	trigger SetCursorHint("HINT_NOICON");
	trigger SetHintString("Hold ^3&&1^7 for Zombie Shield");
	wait 5;
	level thread update_hint_string( trigger );
	for(;;)
	{
		trigger waittill("trigger", player);
		if(player UseButtonPressed())
		{
			if ( !player.shield_cooldown_time )
			{
				player maps/mp/zombies/_zm_equipment::equipment_buy( "alcatraz_shield_zm" );
				player.shield_cooldown_time = 300;
				player thread shield_cooldown();
			}
		}
		wait 0.1;
	}
}

shield_cooldown()
{
	level endon("end_game");

	while(1)
	{
		wait 1;
		self.shield_cooldown_time--;
		if(self.shield_cooldown_time == 0)
		{
			break;
		}
	}
}

update_hint_string( trig )
{
	level endon("end_game");

	foreach(player in level.players)
	{
		player.shield_cooldown_time = 0;
	}
	state = 0;
	prevState = 0;
	while(1)
	{
		foreach(player in level.players)
		{
			
			if ( player.shield_cooldown_time > 0 )
			{
				trig SetHintString("Zombie Shield Cool Down: " + to_mins(player.shield_cooldown_time));
			}
			else if ( !player hasweapon( "alcatraz_shield_zm" ) )
			{
				trig SetHintString("Hold ^3&&1^7 for Zombie Shield");
			}
			else
			{
				trig SetHintString("Took Zombie Shield");
			}
		}
		wait 0.1;
	}
}
		
to_mins( seconds )
{
	hours = 0;
	minutes = 0;

	if( seconds > 59 )
	{
		minutes = int( seconds / 60 );

		seconds = int( seconds * 1000 ) % ( 60 * 1000 );
		seconds = seconds * 0.001;

		if( minutes > 59 )
		{
			hours = int( minutes / 60 );
			minutes = int( minutes * 1000 ) % ( 60 * 1000 );
			minutes = minutes * 0.001;
		}
	}

	if( hours < 10 )
	{
		hours = "0" + hours;
	}

	if( minutes < 10 )
	{
		minutes = "0" + minutes;
	}

	seconds = Int( seconds );
	if( seconds < 10 )
	{
		seconds = "0" + seconds;
	}

	combined = minutes  + ":" + seconds;

	return combined;
}
