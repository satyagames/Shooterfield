package com.jewelmaster{
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
		public static const GS_LEVEL_COMPLETE_WAIT_2:int=56;
		public static const GS_PLAYER_DEATH:int=60;
		public static const GS_PLAYER_DEATH_WAIT:int=65;
		public static const GS_PLAYER_DEATH_WAIT_2:int=66;
		public static const GS_PLAYER_DAMAGE_WAIT:int=80;
		public static const GS_PLAYING:int = 90;
		public static const GS_PAUSED:int = 110;
		public static const GS_GAME_COMPLETE:int = 120;
		public static const GS_GAME_COMPLETE_WAIT:int = 125;
		
		public static const GS_NEXT_LEVEL:int = 140;
		public static const GS_NEXT_LEVEL_WAIT:int = 145;
		public static const GS_SETUP_NEXT_LEVEL_WAIT:int = 150;
		public static const GS_GAME:int = 190;
		
		public static const GS_SWAPPING:int = 200;
		public static const GS_SWAPPING_WAIT:int = 201;
		
		public static const SCREEN_WIDTH:int = 640;
		public static const SCREEN_HEIGHT:int = 480;
		
		
		public static const BOULDER_FRAME_START:int = 1;
		public static const BOULDER_FRAME_MAX:int = 10;
		
		public static const DIRT_FRAME_START:int = 20;
		public static const DIRT_FRAME_MAX:int = 30;
		
		
		
		public static const DIAMOND_FRAME_START:int = 40;
		public static const DIAMOND_FRAME_MAX:int = 50;
		
		public static const ROCK_FRAME_START:int = 60;
		public static const ROCK_FRAME_max:int = 69;
		
		public static const EXIT_FRAME_START:int = 80;
		public static const EXIT_FRAME_MAX:int = 90;
		
		public static const DYNAMITE_FRAME_START:int = 100;
		public static const DYNAMITE_FRAME_MAX:int = 110;
		
		public static const EXPLOSION_FRAME_START:int = 120;
		public static const EXPLOSION_FRAME_MAX:int = 130;
		
		
		public static const MOVING_ENEMY_START:int = 140;
		public static const MOVING_ENEMY_MAX:int = 149;
		
		public static const MOVING_ENEMY_HORIZONTAL_START:int = 160;
		public static const MOVING_ENEMY_HORIZONTAL_MAX:int = 169;
		
		public static const MOVING_ENEMY_VERTICAL_START:int = 180;
		public static const MOVING_ENEMY_VERTICAL_MAX:int = 189;
		
		public static const MOVING_ENEMY_FOLLOW_START:int = 200;
		public static const MOVING_ENEMY_FOLLOW_MAX:int = 209;
		
		public static const EMPTY:int = 0;
		public static const DIRT:int = 1;
		public static const BOULDER:int = 2;
		public static const DIAMOND:int = 3;
		public static const ROCK:int = 4;
		public static const EXIT:int = 5;
		public static const TREASURE:int = 6;
		public static const WALL:int = 7;
		public static const DYNAMITE:int = 8;
		public static const EXPLOSION:int = 9;
		public static const PLAYER:int = 10;
		public static const MOVING_ENEMY:int = 11;
		
		//public static const RENDER_BLOCK_SIZE:int = 34;
		//public static const RENDER_BLOCK_HALF_SIZE:int = 17;
		
		
		public static const PLAYER_MOVING_RIGHT_START:int = 1;
		public static const PLAYER_MOVING_RIGHT_MAX:int = 10;
		
		public static const PLAYER_MOVING_LEFT_START:int = 20;
		public static const PLAYER_MOVING_LEFT_MAX:int = 30;
		
		public static const PLAYER_MOVING_DOWN_START:int = 40;
		public static const PLAYER_MOVING_DOWN_MAX:int = 50;
		
		public static const PLAYER_MOVING_UP_START:int = 60;
		public static const PLAYER_MOVING_UP_MAX:int = 70;
		
		public static const PLAYER_DYING_START:int = 80;
		public static const PLAYER_DYING_MAX:int = 90;
		
		public static const PLAYER_WIN_START:int = 100;
		public static const PLAYER_WIN_MAX:int = 110;
		
		public static const PLAYER_WAITING_START:int = 120;
		public static const PLAYER_WAITING_MAX:int = 130;
		
		
		public static const PS_WAITING:int = 1;
		public static const PS_MOVING_LEFT:int = 2;
		public static const PS_MOVING_RIGHT:int = 3;
		public static const PS_MOVING_UP:int = 4;
		public static const PS_MOVING_DOWN:int = 5;
		public static const PS_WIN:int = 6;
		public static const PS_DIE:int = 7;
		
		public static const MEDAL_GAME_COMPLETED:int = 0;
		public static const MEDAL_DIRT_CLEARED:int = 1;
		public static const MEDAL_DIED_100_DEATHS:int = 2;
		public static const MEDAL_10_ENEMIES_SQUASHED:int = 3;
		public static const MEDAL_30_ENEMIES_SQUASHED:int = 4;
		public static const MEDAL_500_TREASURE_COLLECTED:int = 5
		public static const MEDAL_1000_TREASURE_COLLECTED:int = 6;
		public static const MEDAL_200_GAMES_PLAYED:int = 7;
		
		
		public static const RENDER_SCALE_FACTOR:Number = 1;
		public static const RENDER_BLOCK_SIZE:int = 44
		public static const RENDER_BLOCK_HALF_SIZE:int = 44
		
		public static const ENEMY_TYPE_RANDOM:int = 0;
		public static const ENEMY_TYPE_FOLLOW:int = 1;
		public static const ENEMY_TYPE_VERTICAL:int = 2;
		public static const ENEMY_TYPE_HORIZONTAL:int = 3;
	}
}