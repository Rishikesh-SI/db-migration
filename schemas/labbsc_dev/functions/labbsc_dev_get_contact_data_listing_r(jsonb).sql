-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_contact_data_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_contact_data_listing_r(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_contact_data_listing_r(p_json jsonb, OUT p_contactcount numeric, OUT p_contactjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
declare
 v_pagination jsonb;
 p_pagenumber numeric;
 p_page1_size numeric;
 v_start_date_time timestamp;
 v_end_date_time timestamp;
 v_fromrownumber numeric;
 v_torownumber numeric;
v_pgnum numeric;
v_pgsize numeric;
v_itnum numeric;
v_limit numeric;
v_offset numeric;
p_contactcount1 numeric;

 v_fromrownumber1 numeric;
 v_torownumber1 numeric;
v_pgnum1 numeric;
v_pgsize1 numeric;

begin
	select p_json->>'from_date',
		   p_json->>'to_date',
		   p_json->>'pagenumber',
		   p_json->>'page_size'
		  -- p_json->>'item_number'
		 
	  into v_start_date_time,
	  	   v_end_date_time,
		   v_pgnum,  --1
		   v_pgsize; --10
		  -- v_itnum;  --10
		  
		  
		  IF v_pgnum is null and v_pgsize is null
		  then  
		  v_pgnum:=1 ;
		  v_pgsize:=1000000;
		  elseif v_pgnum is not null and v_pgsize is null then
		  --v_pgnum:=1 ;
		  v_pgsize:=10;
		  END IF;
		  
  	v_fromrownumber := (v_pgnum * v_pgsize - (v_pgsize - 1));
	v_torownumber := (v_pgnum * v_pgsize);
--v_limit := case v_pgnum when 1 then v_pgsize else v_itnum end; --10
--v_offset := case v_pgnum when 1 then 0 else (v_pgsize + (((v_pgnum - 1) * v_itnum) - v_itnum)) end; --0
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
	
	
select '{ "items": '|| json_agg(X) ||'}',count(1) into p_contactjson,p_contactcount
FROM (SELECT module_name as page_name, client_mod_json->'data'->'user_data'->>'Name' as name,
	  custom_module_id,
	  client_mod_json->'data'->'user_data'->>'Email' as email_id,
	  client_mod_json->'data'->'user_data'->>'myQuery' as query,
	  client_mod_json->'data'->'user_data'->>'Contact' as contact,
	  created_date::date,
	  (client_mod_json->'data'->>'page_flag') as page_flag,
	  (client_mod_json->'data'->>'CollegeName') as college_name,
	  (client_mod_json->'data'->>'module_name') as module_name,
	  row_number() over(order by created_date) as rn 
	  FROM labbsc_dev.labbsc_dev_client_web_cust_model 
	  where created_date::date between v_start_date_time and v_end_date_time
	  and (client_mod_json->'data'->>'page_flag') in ('13','15','12.txt'))AS X 
	  where rn between v_fromrownumber and  v_torownumber
	  --group by created_date
	  order by 1 ;
	  --group by created_date
	  --order by 1 
	  --group by created_date
	   
	  --limit v_limit
	  --offset v_offset--)AS X
	
 --    raise notice '%',p_contactjson;
	
	   
--	Select count(1) into p_contactcount from labbsc_dev.labbsc_dev_client_web_cust_model 
--	where created_date::date between v_start_date_time and v_end_date_time and (client_mod_json->'data'->>'page_flag') in ('13','15','12.txt');
	




   
 if p_contactjson is null then
 p_contactjson:='{"items":null}';
 --raise notice '%',p_assetcount;
 --select 1/0;
 end if;
 
 v_pagination:='{"total":'||p_contactcount||',
 				 "current_page":'||coalesce(v_pgnum,0)||'	
				 }';
  p_contactjson:=jsonb_set(p_contactjson,'{pagination}',v_pagination,true);
/*
exception
	when others then
     	p_contactcount := -1;
          p_contactjson := '{"items":[{"error":"no record"}]}';
*/
end;
$_$;


--
