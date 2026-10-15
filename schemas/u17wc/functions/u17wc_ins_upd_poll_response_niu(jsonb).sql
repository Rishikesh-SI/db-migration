-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_ins_upd_poll_response_niu(jsonb)
-- Type: FUNCTION

-- Name: u17wc_ins_upd_poll_response_niu(jsonb); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_ins_upd_poll_response_niu(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

     

declare

V_total_responses		numeric;
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
v_json1 varchar(30000) := '{"data":';
begin 
select current_timestamp into v_currenttimestamp;
         v_json:=p_json ;
         select 
         v_json->'data'->>'poll_id'
         into v_poll_id ;
         
         select v_json->'data'->>'polloption'
	into   v_polldatajson; 
    
      /*if v_polldatajson is not null
       then 
       for v_polldata in select * from json_array_elements(v_polldatajson)
          loop
               
               
               -- v_poll_response_id:=nextval('u17wc.seq_u17wc_poll_response_id');
               
               v_poll_response_id := 0;
          
          select v_polldata->>'option_id'
          into v_option_id;
          
          insert into u17wc.u17wc_poll_response
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
        
end loop;
end if;*/

------------------------------------------------
SELECT  SUM(response_count)
INTO    V_total_responses
FROM u17wc.u17wc_poll_response
where poll_id=v_poll_id;

------------------------------------------------

/*select array(
 select  row_to_json(row) jsonrow
     from(
select 
poll_id,
V_total_responses as total_responses,
(select array_to_json(array_agg(poll_option))
from(
select
response_option_id as option_id,
count(response_count) as response_count
from u17wc.u17wc_poll_response
where poll_id=v_poll_id
group by response_option_id 
 )as poll_option
)row
) */
    
    select array( select  row_to_json(row)
 from (
select v_poll_id poll_id, V_total_responses as total_responses,
(select  array_to_json(array_agg(poll_option)) as array_to_json
 from
 (
     select response_option_id as option_id, SUM(response_count) as response_count
     from u17wc.u17wc_poll_response
     where poll_id=v_poll_id
     group by response_option_id
 )poll_option)
)row)
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

end;

     

$$;


--
