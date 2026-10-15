-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_ins_upd_poll_response_300422(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_ins_upd_poll_response_300422(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_ins_upd_poll_response_300422(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
	
	--insert into labgt01_v1.labgt01_v1_poll_response(user_info)
	--values (v_user_info);
	
	
      if v_polldatajson is not null
       then 
       for v_polldata in select * from json_array_elements(v_polldatajson)
          loop
                v_poll_response_id:=nextval('labgt01_v1.seq_labgt01_v1_poll_response_id');
          
          select v_polldata->>'option_id'
          into v_option_id;
          
          
	
	if v_userguid is not null then 
	
		select user_id
		into strict v_userid
		from labgt01_v1.labgt01_v1_web_user
		where user_guid = v_userguid;
	
		select no_of_ans_allowed into v_no_of_ans_allowed
		from labgt01_v1.labgt01_v1_poll
		where poll_id=v_poll_id;
    
		select count(1)
		into v_uservotecount
		from labgt01_v1.labgt01_v1_user_poll_response
		where poll_id = v_poll_id
		and user_id = v_userid;
		
		if (v_no_of_ans_allowed > v_uservotecount) then
		
		if not exists(select 1 from labgt01_v1.labgt01_v1_user_poll_response
					  where poll_id = v_poll_id and response_option_id =v_option_id and user_id = v_userid ) then
					
					insert into labgt01_v1.labgt01_v1_poll_response
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
				
					insert into labgt01_v1.labgt01_v1_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count)
					values(nextval('labgt01_v1.seq_labgt01_v1_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1);
					
					 insert into labgt01_v1.labgt01_v1_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
																score,player_id,wickets,image_path,video_path,extra)
					values(nextval('labgt01_v1.seq_labgt01_v1_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,null,
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
from labgt01_v1.labgt01_v1_poll_response
where poll_id=v_poll_id
group by response_option_id )a) as poll_option
from 
labgt01_v1.labgt01_v1_poll_response
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
  
 exception
	
     when others then
    		 p_result := -1;
			 p_data:='{"data":null}';

end;
$$;


--
