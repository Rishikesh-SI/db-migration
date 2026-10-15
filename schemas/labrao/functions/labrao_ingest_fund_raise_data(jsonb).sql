-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_ingest_fund_raise_data(jsonb)
-- Type: FUNCTION

-- Name: labrao_ingest_fund_raise_data(jsonb); Type: FUNCTION; Schema: labrao; Owner: -
--

CREATE FUNCTION labrao.labrao_ingest_fund_raise_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
v_by_event_json jsonb;
v_by_nonprofit_json jsonb;
v_by_city_state_json jsonb;
v_by_corporate_json jsonb;
v_raised_amount numeric;
v_supporter_count numeric;
v_campaign_count numeric;
v_updated_at timestamp;
v_nonprofit text;
v_city varchar(500);
v_state_name varchar(500);
v_group_name varchar(500);
i jsonb;
j jsonb;
l jsonb;
begin

select p_json->> 'by_event',
       p_json->> 'by_nonprofit',
       p_json->> 'by_city_state',
       p_json->> 'by_corporate',
	    p_json->> 'updated_at'
	   into
	   v_by_event_json,
	   v_by_nonprofit_json,
	   v_by_city_state_json,
	   v_by_corporate_json,
	   v_updated_at;
	   
	  if v_by_event_json is not null
	  then
	  
	   select v_by_event_json->>'raised_amount',
	         v_by_event_json->>'supporter_count',
			 v_by_event_json->>'campaign_count'
			 into v_raised_amount,
			 v_supporter_count,
			 v_campaign_count;
	  if not exists(select 1 from labrao.labrao_overall_fund) then
	 
	   
	  insert into labrao.labrao_overall_fund
	  (overall_fund_id ,
       raised_amount ,
       supporter_count ,
       campaign_count ,
       last_updated_date 
     )
	 select nextval('labrao.seq_labrao_overall_fund'),
	 v_raised_amount,
	 v_supporter_count,
	 v_campaign_count,
	 v_updated_at;
	 
	 else
	 
	 update labrao.labrao_overall_fund
	 set raised_amount = v_raised_amount,
       supporter_count = v_supporter_count,
       campaign_count = v_campaign_count,
	   updated_date=current_timestamp,
       last_updated_date=v_updated_at;
	 
	 end if;
	 
	end if; 
	 
	if v_by_nonprofit_json is not null
	  then
	  v_raised_amount:=null;
	  v_supporter_count:=null;
	  
	  for i in (select * from jsonb_array_elements(v_by_nonprofit_json))
loop

 select i->>'raised_amount',
	         i->>'supporter_count' ,
			 i->>'nonprofit' 
			 into v_raised_amount,
			 v_supporter_count,
			 v_nonprofit;

	  if not exists(select 1 from labrao.labrao_nonprofit_fund
					where nonprofit =v_nonprofit
				   ) then
	  
	  
	  insert into labrao.labrao_nonprofit_fund
	  (nonprofit_fund_id ,
       raised_amount ,
       supporter_count ,
	   nonprofit 
     )
	 select nextval('labrao.seq_labrao_nonprofit_fund'),
	 v_raised_amount,
	 v_supporter_count,
	 v_nonprofit;
	 
	 else
	 
	 update labrao.labrao_nonprofit_fund
	 set raised_amount = v_raised_amount,
       supporter_count = v_supporter_count ,
	   updated_date=current_timestamp
	 where nonprofit=v_nonprofit  ;
	 
	 end if; 
	 
	 end loop;
	  
 end if;
 
 	if v_by_city_state_json is not null
	  then
	  v_raised_amount:=null;
	  v_supporter_count:=null;
	  
	  for j in (select * from jsonb_array_elements(v_by_city_state_json))
loop

 select j->>'raised_amount',
	         j->>'supporter_count' ,
			 j->>'city' ,
			 j->>'state' 
			 into v_raised_amount,
			 v_supporter_count,
			 v_city,
			 v_state_name;

	  if not exists(select 1 from labrao.labrao_city_state_fund
					where city =v_city
					and state_name=v_state_name
				   ) then
	  
	  
	  insert into  labrao.labrao_city_state_fund
	  (city_state_fund_id ,
       raised_amount ,
       supporter_count ,
	   city,
	   state_name
     )
	 select nextval('labrao.seq_labrao_city_state_fund'),
	 v_raised_amount,
	 v_supporter_count,
	 v_city,
	 v_state_name;
	 
	 else
	 
	 update labrao.labrao_city_state_fund
	 set raised_amount = v_raised_amount,
       supporter_count = v_supporter_count ,
	   updated_date=current_timestamp
	 where city=v_city
	 and state_name=v_state_name;
	 
	 end if; 
	 
	 end loop;
	  
 end if;
 
 
 	if v_by_corporate_json is not null
	  then
	  v_raised_amount:=null;
	  v_supporter_count:=null;
	  
	  for l in (select * from jsonb_array_elements(v_by_corporate_json))
loop

 select l->>'raised_amount',
	         l->>'supporter_count' ,
			 l->>'corporate' 
			 into v_raised_amount,
			 v_supporter_count,
			 v_group_name;

	  if not exists(select 1 from  labrao.labrao_corporate_fund
					where group_name =v_group_name
				   ) then
	  
	  
	  insert into  labrao.labrao_corporate_fund
	  (corporate_fund_id ,
       raised_amount ,
       supporter_count ,
	   group_name 
     )
	 select nextval('labrao.seq_labrao_corporate_fund'),
	 v_raised_amount,
	 v_supporter_count,
	 v_group_name;
	 
	 else
	 
	 update labrao.labrao_corporate_fund
	 set raised_amount = v_raised_amount,
       supporter_count = v_supporter_count ,
	   updated_date=current_timestamp
	 where group_name=v_group_name  ;
	 
	 end if; 
	 
	 end loop;
	  
 end if;
	   
	   p_result:=1;
	   
	   

end;
$$;


--
