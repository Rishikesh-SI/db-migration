-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_move_yho_users()
-- Type: FUNCTION

-- Name: gpn_move_yho_users(); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_move_yho_users(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_user_id numeric;
v_curr_date date:=current_date;
i record;
v_match_id numeric;
v_league_id numeric;
begin
v_curr_date:=v_curr_date-interval '5 hours 30 minutes';
---raise notice '%',v_curr_date;
 

for i in  (select distinct gm.match_id,gm.league_id    from  gpnv2.gpn_user_series_subscription_map us
					join  gpnv2.gpn_series_match_map sm
		on sm.series_id=us.data_value_id
		join gpnv2.gpn_match gm
		on gm.source_object_id=sm.source_object_id
					 where  gm.updated_date>=v_curr_date
		   
		   )
  loop
  
  
 v_match_id:=i.match_id;
 v_league_id:=i.league_id;
 
		 	insert into gpnv2.gpn_user_event_subscription_map(user_event_subscription_map_id, user_id, application_id, league_id, event_id,
														  subscription_id, data_value_id, data_value, lookup_value)
		select nextval('gpnv2.seq_gpn_user_event_subscription_map_id'), t1.user_id, t1.application_id, t1.league_id, t1.event_id, t1.subscription_id,
				gm.match_id, t1.data_value, string_to_array((t1.application_id||'-'||t1.league_id||'-'||gm.match_id||'-'||t1.event_id||'-'||
															t1.subscription_id||'-'||1),',')
		from gpnv2.gpn_user_series_subscription_map t1
		join gpnv2.gpn_series_match_map sm
		on sm.series_id=t1.data_value_id
		join gpnv2.gpn_match gm
		on gm.source_object_id=sm.source_object_id
		where gm.match_id=v_match_id
		and t1.data_value_id is not null
		and t1.application_id in (4,5,6)
		and not exists(select 1
					from gpnv2.gpn_user_event_subscription_map uesm
					where uesm.application_id = t1.application_id
					and uesm.user_id = t1.user_id
					and uesm.league_id = t1.league_id
					and uesm.event_id = t1.event_id
					and uesm.subscription_id = t1.subscription_id
					and uesm.data_value_id = gm.match_id);
					
			update gpnv2.gpn_user_event_subscription_map uesm
				set data_value_id = v_match_id,
					lookup_value = string_to_array((uesm.application_id||'-'||uesm.league_id||'-'||v_match_id||'-'||uesm.event_id||'-'||
													uesm.subscription_id||'-'||u.language_id),',')
				from gpnv2.gpn_user u
				where u.application_id in (4,5,6)
				and uesm.application_id = u.application_id
				and u.user_id = uesm.user_id
				---and uesm.data_value = v_match_code
				and uesm.data_value_id = v_match_id
				and uesm.league_id = v_league_id
				and uesm.subscription_id = 4
				and uesm.application_id in (4,5,6);	 	
					

		---	end if;
			
		 
			with cte as(
select     t.topic_id,uesm.user_id,uesm.application_id
				from gpnv2.gpn_user_event_subscription_map uesm
				join gpnv2.gpn_topic t
				on  uesm.application_id in (4,5,6)
				   and uesm.application_id = t.application_id
				 and uesm.event_id=t.event_id
				 and uesm.league_id=t.league_id
				 and uesm.data_value_id=t.match_id
			    and uesm.lookup_value <@ t.lookup_values
				  where t.application_id in (4,5,6)
	              and t.match_id=v_match_id
					and t.league_id=v_league_id
) 
	insert into gpnv2.gpn_user_topic_map(user_topic_map_id, user_id, application_id, topic_id)
				 
select  nextval('gpnv2.seq_gpn_user_topic_map_id'),u.user_id,gtm.application_id,gtm.topic_id
from cte gtm
				join gpnv2.gpn_user u
				on u.application_id = gtm.application_id
				and u.application_id = gtm.application_id
				and u.user_id = gtm.user_id
				where   u.application_id in (4,5,6)
				and u.is_notification_enabled = 1
				  and not exists(select 1 from gpnv2.gpn_user_topic_map gt
							  where gt.application_id=gtm.application_id
							   and gt.user_id=gtm.user_id
							   and gt.topic_id=gtm.topic_id);
				
				raise notice '%,%',v_match_id,v_league_id;
				
				
	 	end loop;	
		
		
		p_out:=1;

exception when others then
p_out:=-1;
 
end;
$$;


--
