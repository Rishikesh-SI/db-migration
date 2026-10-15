-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_venue_filter_values(numeric, numeric[], character varying[], numeric)
-- Type: FUNCTION

-- Name: zeven_set_venue_filter_values(numeric, numeric[], character varying[], numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_venue_filter_values(p_venue_masterid numeric, p_arr_filter_masterid numeric[], p_arr_filter_value character varying[], p_opt_type numeric, OUT p_ret_type numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
v_sysdate                       timestamp(0) = current_timestamp at time zone 'utc';
v_zvn_venue_filter_valuesid     zeven.zeven_venue_filter_values.zeven_venue_filter_valuesid%type ;
v_sql_cnt                       numeric;
v_venue_parentid                numeric;
v_is_parent_filter_exists       numeric = 0;

begin

----------------opt type 1 for insert data into table---------
  begin
    select  venue_parentid
    into strict v_venue_parentid
    from    zeven.zeven_venue_master 
    where   venue_masterid::numeric = p_venue_masterid;
   exception 
    when no_data_found then
    v_venue_parentid := 0; 
  end; 
  
  select  count(1)
  into    v_is_parent_filter_exists
  from    zeven.zeven_venue_filter_values
  where   venue_masterid::numeric = v_venue_parentid;
  
  if p_opt_type =1 then
    for i in 1..array_length(p_arr_filter_masterid,1) 
	loop
      insert into zeven.zeven_venue_filter_values
      (
        zeven_venue_filter_valuesid,venue_masterid,zeven_filter_masterid,venue_filter_value,is_deleted,is_published,created_date,updated_date                   
      )
      values
      (
        nextval('zeven.seq_zeven_venue_filter_values_id'),p_venue_masterid,p_arr_filter_masterid[i],p_arr_filter_value[i],0,1,v_sysdate,v_sysdate
      );
	end loop;
  end if;

----------------opt type 2 for update table---------
 if p_opt_type =2 then
  delete from  zeven.zeven_venue_filter_values
  where   venue_masterid::numeric = p_venue_masterid;
  
  /* commit; */
  
   for i in 1..array_lenght(p_arr_filter_masterid,1)
   loop
    insert into zeven.zeven_venue_filter_values
    (
      zeven_venue_filter_valuesid,venue_masterid,zeven_filter_masterid,venue_filter_value,is_deleted,is_published,created_date,updated_date                   
    )
    values
    (
      nextval('zeven.seq_zeven_venue_filter_values_id'),p_venue_masterid,p_arr_filter_masterid[i],p_arr_filter_value[i],0,1,v_sysdate,v_sysdate
    );
	end loop;
 end if;
  
  if v_is_parent_filter_exists > 0 then
    insert into zeven.zeven_venue_filter_values
    (
      zeven_venue_filter_valuesid,venue_masterid,zeven_filter_masterid,venue_filter_value,is_deleted,is_published,created_date,updated_date                   
    )
    select  nextval('zeven.seq_zeven_venue_filter_values_id'),p_venue_masterid,zeven_filter_masterid,venue_filter_value,is_deleted,is_published,v_sysdate,v_sysdate
    from    zeven.zeven_venue_filter_values
    where   venue_masterid::numeric = v_venue_parentid;
    
    /* commit; */
  end if;
  

p_ret_type := 1;
/*exception 
when others then 
p_ret_type := -1111;*/

 
end;

$$;


--
