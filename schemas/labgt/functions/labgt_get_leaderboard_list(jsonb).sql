-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_leaderboard_list(jsonb)
-- Type: FUNCTION

-- Name: labgt_get_leaderboard_list(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_leaderboard_list(p_data jsonb, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_limit numeric;
v_order character varying;
v_module character varying;
i record;
v_total_count numeric;
	
begin

/*
select * from labgt.labgt_get_leaderboard_list(
	'
	{
  "order": "desc",
  "inum": 6,
	"module":"ipl_retention_2026"
}')
*/

select p_data->>'order',
       p_data->>'inum',
	   p_data->>'module'

INTO
		v_order,
		v_limit,
		v_module;	
		
		
	if v_module='ipl_retention_2025' then

		select jsonb_agg(row_to_json(t)) from (select case when player_name='Vijay Shankar' then 'Vijay Shankar (UC)' else player_name end as player_name,count,
               round((count/(select count(cwj.*) from labgt.labgt_custom_web_json cwj
                                join labgt.labgt_web_user wu on cwj.datajson->'data'->>'user_guid' = wu.user_guid
                                where cwj.module_name='ipl_retention_2025')*100),2) as vote_percentage,
                 dense_rank() over (order by count desc) as rank from 
                 labgt.labgt_retention_players 
                  group by player_name,count
                  order by  
                (case when v_order='asc' then count when v_order='desc' then -count else -count end),player_name  
                limit (select v_limit))t
		into p_json;

	elsif v_module='ipl_retention_2026' then

		SELECT jsonb_agg(row_to_json(t))
			FROM (
				SELECT
					player_id,
					player_name,
					skill_id,
					skill,
					nationality_id,
					nationality,
					national_team_id,
					national_team,
					count,
					round((count/(select count(cwj.*) from labgt.labgt_custom_web_json cwj
                                join labgt.labgt_web_user wu on cwj.datajson->'data'->>'user_guid' = wu.user_guid
                                where cwj.module_name='ipl_retention_2025')*100),2) as vote_percentage,
					DENSE_RANK() OVER (ORDER BY count DESC) AS rank
				FROM labgt.labgt_retention_players_2026
				GROUP BY
					player_id,
					player_name,
					skill_id,
					skill,
					nationality_id,
					nationality,
					national_team_id,
					national_team,
					count
                  order by  
                (case when v_order='asc' then count when v_order='desc' then -count else -count end),player_name  
                limit (select v_limit))t
		into p_json;
        	
	end if;

end;
$$;


--
