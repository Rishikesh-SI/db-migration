-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_ins_broadcast(jsonb)
-- Type: FUNCTION

-- Name: sibot_get_ins_broadcast(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_ins_broadcast(p_input_json jsonb, OUT p_out_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
/*select * from sibot.sibot_get_ins_broadcast(
'{
  "start_date": "2019-02-26 06:04:00",
  "end_date": "2019-02-27 06:04:00",
  "application_id": "1",
  "opt_type": "G",
  "labels": null,
  "list_type": null,
  "status": null
}');
*/
/*
select * from sibot.sibot_get_ins_broadcast('
{
  "start_date": "2019-02-26 08:05:58",
  "end_date": "2019-02-27 08:05:58",
  "application_id": "1",
  "opt_type": "I",
  "labels": [
    {
      "label_name": "Oman vs Japan",
      "label_id": "",
      "league_id": "38",
      "match_id": "709",
      "team_a_id": "144",
      "team_b_id": "62",
      "match_start_date": "2/26/2019 9.00.00 AM",
      "match_end_date": "2/27/2019 9.00.00 AM"
    },
    {
      "label_name": "FC Augsburg vs 1. FSV Mainz 05",
      "label_id": "",
      "league_id": "1",
      "match_id": "758",
      "team_a_id": "13",
      "team_b_id": "4",
      "match_start_date": "2/26/2019 9.00.00 AM",
      "match_end_date": "2/27/2019 9.00.00 AM"
    },
    {
      "label_name": "FC Schalke 04 vs Borussia Mönchengladbach",
      "label_id": "",
      "league_id": "1",
      "match_id": "757",
      "team_a_id": "15",
      "team_b_id": "7",
      "match_start_date": "2/26/2019 11.00.00 PM",
      "match_end_date": "2/27/2019 11.00.00 PM"
    }
  ],
  "list_type": "M",
  "status": "1"
}
');

truncate table  sibot.sibot_list

select * from sibot.sibot_list

alter sequence sibot.seq_sibot_list_id restart with 1 */
declare
	v_opt_type character(2);
    v_list_type character(2);
	v_channel_id numeric;
    v_list_name text;
    v_list_key text;
    v_application_id numeric;
    v_league_id numeric;
    v_match_id numeric;
    v_team_a_id numeric;
    v_team_b_id numeric;
    v_status numeric;
    v_start_date timestamp with time zone;
    v_end_date timestamp with time zone;
    v_label json;
    v_item json;
    
begin
	select p_input_json->> 'opt_type', p_input_json->>'application_id',p_input_json->>'list_type',
           p_input_json->>'status',p_input_json->>'start_date',p_input_json->>'end_date',
           p_input_json->>'labels'
    into   v_opt_type, v_application_id,v_list_type,
           v_status,v_start_date,v_end_date,v_label;
    
              
    if v_opt_type = 'G' 
    then
    	p_result = 1;
	elsif v_opt_type = 'I' 
    then
         update sibot.sibot_list set status = 0;
          FOR v_item IN SELECT * FROM json_array_elements(v_label)
          LOOP
              select v_item->> 'label_name',v_item->> 'label_id',v_item->>'league_id',
                     v_item->>'match_id', v_item->>'team_a_id', v_item ->>'team_b_id'
              into   v_list_name,v_list_key,v_league_id,v_match_id,v_team_a_id,v_team_b_id;
          insert into sibot.sibot_list(list_id,list_name,list_key,application_id,
                                       list_type,league_id,match_id,team_a_id,team_b_id,status,
                                       created_date)
          select nextval('sibot.seq_sibot_list_id'),v_list_name,v_list_key,v_application_id,
                 v_list_type,v_league_id,v_match_id,v_team_a_id,v_team_b_id,1,now()::date; 
          end loop;
          p_result := 2;

    else
         p_result := -1;
    end if;
    
    
           if p_result =1 
           then
    	       select ('{"league":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		       from (select  league_id,(select array_to_json(array_agg(row_to_json(user_projects)))
                                        from (select match_id,team_a_id,team_b_id,match_name,match_start_date,match_end_date
                                              from sibot.sibot_match x
                                              where x.league_id=y.league_id 
                                              and match_start_date between v_start_date and  v_end_date 
                
                                              ) user_projects
                                       ) as matches
                   from sibot.sibot_league y 
                   ) row where matches is not null 
		            into p_out_json;
         else
    	      p_out_json := '{}'::jsonb;
        end if;
/*exception
	when others then
    	p_result := -1;
        p_out_json := '{}'::jsonb;*/
end;

$$;


--
