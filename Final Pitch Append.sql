INSERT INTO final_pitch
SELECT 
batter_name, pitcher_name, pitch_type, game_date, release_speed, release_pos_x,
release_pos_z, batter as batter_id, pitcher as pitcher_id, events, description, spin_dir, zone as pitch_zone,
game_type, stand, p_throws, home_team, away_team, type as pitchtype, hit_location,
bb_type, balls, strikes, game_year, pfx_x, pfx_z, plate_x, plate_z, outs_when_up,
inning, inning_topbot, hc_x, hc_y, ax, ay, az, sz_top, sz_bot, hit_distance_sc,
launch_speed, launch_angle, effective_speed, release_spin_rate, release_extension,
game_pk, release_pos_y, estimated_ba_using_speedangle, estimated_woba_using_speedangle,
woba_value, woba_denom, babip_value, iso_value, launch_speed_angle, at_bat_number,
pitch_number, pitch_name, home_score, away_score, bat_score, fld_score, post_away_score,
post_home_score, post_bat_score, post_fld_score, if_fielding_alignment, of_fielding_alignment,
spin_axis, delta_home_win_exp, delta_run_exp, bat_speed, swing_length, estimated_slg_using_speedangle,
delta_pitcher_run_exp, hyper_speed, home_score_diff, bat_score_diff, home_win_exp, bat_win_exp,
age_pit_legacy, age_bat_legacy, age_pit, age_bat, n_thruorder_pitcher, n_priorpa_thisgame_player_at_bat,
pitcher_days_since_prev_game, batter_days_since_prev_game, pitcher_days_until_next_game,
batter_days_until_next_game, api_break_z_with_gravity, api_break_x_arm, api_break_x_batter_in,
arm_angle

FROM (
SELECT row_number () OVER (PARTITION BY at_bat_number, game_date, batter, 
pitcher ORDER BY pitch_number DESC) as row_n, *,
CONCAT (b.name_last, ' ,', b.name_first) as batter_name,
CONCAT (c.name_last, ' ,', c.name_first) as pitcher_name
FROM raw_pitch a
left join raw_player_lookup b on a.batter = b.key_mlbam --batter name
left join raw_player_lookup c on a.pitcher = c.key_mlbam --pitcher name
) 
WHERE row_n = 1