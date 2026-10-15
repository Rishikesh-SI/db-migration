-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_season_team_r(jsonb)
-- Type: FUNCTION

-- Name: labmi_get_season_team_r(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_season_team_r(p_json jsonb, OUT p_season_team_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

v_season_id numeric ;
p_season_id numeric;
p_week_id numeric;
p_match_id character varying;
v_is_captain numeric;
v_is_vice_captain numeric;
v_count numeric;
tot_cnt numeric;
begin

select p_json->>'season_id',
p_json->>'week_id',
p_json->>'match_id'
into 
p_season_id,
p_week_id,
p_match_id;


		DROP TABLE IF EXISTS cte_tab;

		CREATE TEMP TABLE cte_tab as
		select d->>'name' as name ,d->>'id' as Player_id,
			   d->>'skill_name' as  skill_name,
			   d->>'is_wicket_keeper' as is_wicket_keeper,
			   d->>'is_captain' as is_captain ,
			   d->>'country_name' as country_name ,
			   d->>'country_id' as country_id,
               (d->>'is_retained')::boolean as is_retained
		from(select jsonb_array_elements(b) d
			 from (select team_json->'players' b
				   from labmi.labmi_user_team
				   where season_id::numeric = p_season_id and week_id = p_week_id and match_id=p_match_id
				   order by 1 desc) c
			)row;
	
	
	       select count(1) into tot_cnt from labmi.labmi_user_team where season_id::numeric = p_season_id and week_id = p_week_id and match_id=p_match_id;
		   
			select Player_id, count(1) into v_is_captain, v_count from cte_tab
			where is_captain = 'true'
			group by Player_id 
			order by 2 desc
			limit 1;

           raise notice '%',v_is_captain;
		  -- select 1/0;
		    
			select Player_id, count(1) into v_is_vice_captain, v_count from cte_tab
			where is_wicket_keeper = 'true' 
			and Player_id::numeric <> v_is_captain
			group by Player_id 
			order by 2 desc
			limit 1;
            
           v_is_vice_captain:=case when v_is_vice_captain is null then 0 end; 
           v_is_captain:=case when v_is_captain is null then 0 end;
            
            

			select '{"players":'|| array_to_json(array_agg(row))||'}'
			into p_season_team_json 
			from (select * from (
select * from 
			(select Player_id,
			  name,skill_name,
			  1 as is_captain,
			  0 as is_wicket_keeper,
			 count(1)   ,
			 ((count(1)*100)/ tot_cnt) AS percentage,
			 country_id::numeric,
             country_name,
            is_retained
			from cte_tab
			where Player_id::numeric = v_is_captain
			group by Player_id,name,skill_name,country_id::numeric,is_retained,country_name
			order by 6 desc) tab
			union all
			select * from 
			(select 
			 Player_id,name,skill_name,
			  0 as is_captain,
			  1 as is_wicket_keeper,count(1)  ,
			 ((count(1)*100)/ tot_cnt) AS percentage,
			 country_id::numeric,
             country_name,
             is_retained
			from cte_tab
			where Player_id::numeric = v_is_vice_captain
			group by Player_id,name,skill_name,country_id::numeric,is_retained,country_name
			order by 6 desc) tab_1
			union all
			select * from 
			(select Player_id,name,skill_name, 0 as is_captain,
			  0 as is_wicket_keeper,count(1) ,
			((count(1)*100)/ tot_cnt) AS percentage,
			 country_id::numeric,
             country_name,
             is_retained
			 from cte_tab
			where Player_id::numeric not in (v_is_vice_captain,v_is_captain)
			group by Player_id,name,skill_name ,country_id::numeric,is_retained,country_name
			order by 6 desc
			) tab_2
			)tab_3
			order by case when skill_name='Batter' then 0 
						  when is_wicket_keeper=1 or skill_name='Wicket-Keeper'  then 1
			              when skill_name='All-Rounder' then 2   
						  when skill_name='Batter' then 3 end ,percentage desc
			)row;

--  p_season_team_json := '{}';
 
 
/*exception
	when others then
        p_season_team_json := '{}';
*/
end;

$$;


--
