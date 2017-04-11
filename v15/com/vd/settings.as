package com.vd{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public class settings {
		public static const GS_INIT:int=0;
		public static const GS_MAIN_MENU:int = 2;
		public static const GS_MAIN_MENU_WAIT:int = 3;
		public static const GS_SETUP_NEW_GAME:int=10;
		public static const GS_SETUP_NEW_GAME_WAIT:int=15;
		public static const GS_START_GAME:int=20;
		public static const GS_START_GAME_WAIT:int=25;
		public static const GS_GAME_OVER:int=30;
		public static const GS_GAME_OVER_WAIT:int=35;
		public static const GS_GAME_OVER_WAIT_2:int=36;
		public static const GS_GAME_OVER_WAIT_3:int=37;
		public static const GS_LEVEL_COMPLETE:int=50;
		public static const GS_LEVEL_COMPLETE_WAIT:int=55;
		public static const GS_PLAYER_DEATH:int=60;
		public static const GS_PLAYER_DEATH_WAIT:int=65;
		public static const GS_INTRO_CUTSCENE:int=70;
		public static const GS_INTRO_CUTSCENE_WAIT:int=75;
		public static const GS_PLAYER_DAMAGE_WAIT:int=80;
		public static const GS_PLAYING:int = 90;
		public static const GS_DELAY_SCENE_CHANGE:int = 100;
		public static const GS_PAUSED:int = 110;
		public static const GS_GAME_COMPLETE:int = 120;
		public static const GS_GAME_COMPLETE_WAIT:int = 125;
		public static const GS_INTRO_MOVIE:int = 130;
		public static const GS_INTRO_MOVIE_WAIT:int = 135;
		public static const GS_NEXT_LEVEL:int = 140;
		public static const GS_NEXT_LEVEL_WAIT:int = 145;
		public static const GS_SETUP_NEXT_LEVEL_WAIT:int = 150;
		
		//
		public static const WATER_LEVEL:int =450
		public static const FIRING_DELAY:int = 15
		public static const FIRING_DELAY_RAPID:int =7
		public static const SCREEN_WIDTH:int = 900
		public static const SCREEN_HEIGHT:int = 486
		//
		public static const PLANET_LEVEL:Number = 440
		//public static const DINO_START_LOC:Point = new Point(250, 450)
		
		public static const PLAYER_SITTING_OFFSET:Point = new Point(50, -242)
	
		
		public static const parallax1Xsize:Number = 900
		public static const parallax2Xsize:Number = 900
		public static const parallax3Xsize:Number = 900
		public static const parallax4Xsize:Number = 900
		
		public static const BOY:int =0
		public static const GIRL:int = 1
		
	
		
		public static const CANNON_FACTOR:Number  = .35
		public static const GRAVITY:Number  = .25
		//public static const DINO_JUMP_HEIGHT:Number  = 100
		
		public static const ENEMY_BASE_Y:int  = 450
		public static const ENEMY_BIRD_DIVE_DEPTH:int  = 200
		
		public static const ENEMY_SUBTYPE_1:int = 1
		public static const ENEMY_SUBTYPE_2:int = 2
		public static const ENEMY_SUBTYPE_3:int = 3
		
		public static const ENEMY_1:int  = 1
		public static const ENEMY_2:int  = 2
		public static const ENEMY_3:int  = 3
		public static const ENEMY_4:int  = 4
		public static const ENEMY_5:int  = 5
		public static const ENEMY_6:int  = 6
		public static const ENEMY_7:int  = 7
		public static const ENEMY_8:int  = 8
		public static const ENEMY_9:int  = 9
		public static const ENEMY_10:int  = 10
		
		public static const BONUS_1:int  = 20
		public static const BONUS_2:int  = 21
		public static const BONUS_3:int  = 22
		public static const BONUS_4:int  = 23
		public static const BONUS_5:int  = 24
		
		public static const HIT_2_TIMES:int  = 20
		public static const HIT_3_TIMES:int  = 21
		public static const HIT_4_TIMES:int  = 22
		public static const HIT_5_TIMES:int  = 23
		public static const HIT_6_TIMES:int  = 24
		public static const HIT_7_TIMES:int  = 25
		public static const HIT_8_TIMES:int  = 26
		public static const HIT_9_TIMES:int  = 27
		public static const HIT_10_TIMES:int  = 28
		public static const HIT_MAX_TIMES:int  = 29
		
		
		
		public static const TREE_NORMAL:int  =1
		public static const TREE_DAMAGED_FRAME:int  =2
		public static const TREE_HURT_PLAYER:int  = 3
		
		public static const ITEM_POWER_UP:int  = 1;
		public static const ITEM_MULTI_HIT:int  = 2;
		public static const ITEM_SATELITE:int  = 3;
		public static const ITEM_BLOCKER:int  = 4;
		
		
	
		public static const PARTICLE_ENEMY_TRAIL_1:int  = 1;
		public static const PARTICLE_ENEMY_TRAIL_2:int  = 2;
		public static const PARTICLE_ENEMY_TRAIL_3:int  = 3;
		public static const PARTICLE_ENEMY_TRAIL_4:int  = 4;
		public static const PARTICLE_ENEMY_TRAIL_5:int  = 5;
		public static const PARTICLE_ENEMY_TRAIL_6:int  = 6;
		public static const PARTICLE_ENEMY_TRAIL_7:int  = 7;
		public static const PARTICLE_ENEMY_TRAIL_8:int  = 8;
		public static const PARTICLE_ENEMY_TRAIL_9:int  = 9;
		public static const PARTICLE_ENEMY_TRAIL_10:int  = 10;
		
		public static const PARTICLE_EXPLOSION_1:int  = 11;
		public static const PARTICLE_EXPLOSION_2:int  = 12;
		public static const PARTICLE_EXPLOSION_3:int  = 13;
		
		public static const BULLET_TYPE_1:int  = 1
		public static const BULLET_TYPE_2:int  = 2
		public static const BULLET_TYPE_BIG:int  =3
		public static const BULLET_TYPE_HOMING:int  = 4
		public static const BULLET_TYPE_LASER:int  = 5
		
		public static const SATELITE_TYPE_1:int  = 40
		public static const SATELITE_TYPE_2:int  = 41
		public static const SATELITE_TYPE_3:int  = 42
		
		public static const BLOCKER_1:int  = 50
		public static const BLOCKER_2:int  = 51
		public static const BLOCKER_3:int  = 52
		
		
		public static const POWERUP_SPRAY_1:int  = 1
		public static const POWERUP_SPRAY_2:int  = 2
		public static const POWERUP_LASER:int  = 3
		public static const POWERUP_BIG_BULLET:int  = 4
		public static const POWERUP_RAPID_FIRE:int  = 5
		public static const POWERUP_HOMING:int  = 7
		public static const POWERUP_WAVY:int  = 6
		
		public static const POWERUP_LIGHTNING:int  = 8;
		
		
		public static var MEDAL_GAME_COMPLETED:int = 0;
		public static var MEDAL_100_ENEMY_VECTORS_DESTROYED:int = 1;
		public static var MEDAL_500_ENEMY_VECTORS_DESTROYED:int = 2;
		public static var MEDAL_1000_ENEMY_VECTORS_DESTROYED:int = 3;
		public static var MEDAL_5000_BULLETS_FIRED:int = 4;
		public static var MEDAL_25_SATELITES_DESTROYED:int = 5;
		public static var MEDAL_50_SATELITES_DESTROYED:int = 6;
		public static var MEDAL_50_PLANETS_DEFENDED:int = 7;
		public static var MEDAL_100_PLANETS_DEFENDED :int = 8;
		public static var MEDAL_100_GAMES_PLAYED:int = 9;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}