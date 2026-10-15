-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_ins_upd_poll_response(jsonb)
-- Type: FUNCTION

-- Name: labkxip_ins_upd_poll_response(jsonb); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_ins_upd_poll_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

v_json jsonb;
v_poll_id numeric;
v_option_id numeric;
v_poll_response_id numeric;
v_currenttimestamp timestamp;
v_polldatajson json;
v_polldata json;
v_getarr jsonb[];
v_getjson jsonb;
p_data1 jsonb;
v_user_info jsonb;
v_json1 varchar(30000) := '{"data":';
v_userguid character varying(256);
v_userid numeric;
v_uservotecount numeric;
v_no_of_ans_allowed numeric;
v_poll_option_id numeric;
begin 
select current_timestamp into v_currenttimestamp;
         v_json:=p_json ;
         select 
         v_json->'data'->>'poll_id'
         into v_poll_id ;
         
         select v_json->'data'->>'polloption'
	into   v_polldatajson; 
    
	select v_json->'data'->>'user_info',
		   v_json->'data'->>'user_guid'
	into  v_user_info,v_userguid
	      ; 
	
	--insert into labkxip.labkxip_poll_response(user_info)
	--values (v_user_info);
	
	
      if v_polldatajson is not null
       then 
       for v_polldata in select * from json_array_elements(v_polldatajson)
          loop
                v_poll_response_id:=nextval('labkxip.seq_labkxip_poll_response_id');
          
          select v_polldata->>'option_id'
          into v_option_id;
          
          
	
	if v_userguid is not null then 
	
		select user_id
		into strict v_userid
		from labkxip.labkxip_web_user
		where user_guid = v_userguid;
	
		select no_of_ans_allowed into v_no_of_ans_allowed
		from labkxip.labkxip_poll
		where poll_id=v_poll_id;
    
		select count(1)
		into v_uservotecount
		from labkxip.labkxip_user_poll_response
		where poll_id = v_poll_id
		and user_id = v_userid;
		
		if (v_no_of_ans_allowed > v_uservotecount) then
		
		if not exists(select 1 from labkxip.labkxip_user_poll_response
					  where poll_id = v_poll_id and response_option_id =v_option_id and user_id = v_userid ) then
					
					insert into labkxip.labkxip_poll_response
          (
            poll_response_id,
		    poll_id,
            response_option_id,
            created_date,
            updated_date,
            created_by,
            updated_by,
            is_active,
            is_deleted,
            is_published,
            poll_response_guid,
            response_count
          )
         values 
         (
         v_poll_response_id,
         v_poll_id,
         v_option_id,
         v_currenttimestamp,
         v_currenttimestamp,
          1,
          1,
          1,
          1,
          1,
          1 ,
          1
		 
    );
				
					insert into labkxip.labkxip_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count)
					values(nextval('labkxip.seq_labkxip_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1);
					
					 insert into labkxip.labkxip_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
																score,player_id,wickets,image_path,video_path,extra)
					values(nextval('labkxip.seq_labkxip_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,null,
														 null,null,null,null,null,null);
				   
			        end if;
	 
	     end if;
		 
	end if;
        
end loop;
end if;

select array(
 select  row_to_json(row) jsonrow
     from(
select 
poll_id,
sum(response_count) as total_responses,
(select array_to_json(array_agg(a))
from(
select
response_option_id as option_id,
count(response_count) as response_count
from labkxip.labkxip_poll_response
where poll_id=v_poll_id
group by response_option_id )a) as poll_option
from 
labkxip.labkxip_poll_response
where poll_id=v_poll_id
group by poll_id
)row
) 
into v_getarr ;

 foreach v_getjson in array v_getarr
    loop
      v_json1 := v_json1||v_getjson||',';
     end loop;
      v_json1 := substring(v_json1,1,(length(v_json1)-1));
      v_json1 := v_json1||'}';
      
      p_data  := v_json1::jsonb;

 p_result := 1;
     
  if p_result = 1 then
    		
       p_data := p_data;
          
     end if;  
 /*  
 exception
	
     when others then
    		 p_result := -1;
*/
end;
$$;


--
