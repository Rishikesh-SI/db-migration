-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_timewise_user_list(jsonb)
-- Type: FUNCTION

-- Name: labbsc_get_timewise_user_list(jsonb); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_timewise_user_list(p_json jsonb, OUT p_user_list jsonb, OUT p_record_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_created_date timestamp;
v_updated_date timestamp;
v_page_number numeric;
v_item_number numeric;
v_fromrownumber numeric;
v_torownumber numeric;
v_count numeric;
begin
select p_json->>'created_date',
        p_json->>'updated_date',
		p_json->>'page_number',
		p_json->>'item_number'
		into v_created_date,
		v_updated_date,
		v_page_number,
		v_item_number;
		
		
		
v_fromrownumber := (v_page_number * v_item_number - (v_item_number - 1));
v_torownumber   := (v_page_number * v_item_number);

select cnt, '{"userlist":['||string_agg(row_to_json(row)::text,',')||'],
              "pagination":{
			   "total_user_count": "",
               "next_page_number": ""
			  }}' 
		from(
		select data::jsonb,page_flag,created_date,updated_date,count(1)over() as cnt,sl_no from
		(
			select client_mod_json->>'data'   as data,
			client_mod_json->>'page_flag' as page_flag,
			row_number()over(order by created_date) as sl_no,
			created_date,updated_date from (
             select cw.client_mod_json,
			  (cw.created_date at time zone 'utc' +interval '330 minute') ::date as created_date, 
			(cw.updated_date at time zone 'utc' +interval '330 minute') ::date as updated_date
			 from
labbsc.labbsc_client_web_cust_model cw
 where  cw.module_name = 'user_profile') as tb
		where created_date =  coalesce(v_created_date,created_date)  
			and updated_date=
			case when v_created_date is null then  v_updated_date 
			else updated_date end  
			)tc
		)
 as row
 where sl_no between v_fromrownumber and v_torownumber
 group by cnt
 into p_record_count,p_user_list;
  
 
		
		
		end;
$$;


--
