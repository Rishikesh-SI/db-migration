-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_venue_type(numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: zeven_set_venue_type(numeric, character varying, numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_venue_type(p_zeven_venue_typeid numeric, p_venue_type character varying, p_opt_type numeric, OUT p_ret_type numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_sysdate            timestamp(0) = current_timestamp;
v_zeven_venue_typeid zeven.zeven_venue_type.zeven_venue_typeid %type ;

begin

----------------opt type 1 for insert data into table---------
if p_opt_type=1 then

    v_zeven_venue_typeid := nextval('zeven.seq_zeven_venue_type_id');
    
    insert into zeven.zeven_venue_type
    (zeven_venue_typeid, venue_type ,created_date ,updated_date  )   
    values
    (v_zeven_venue_typeid,p_venue_type,v_sysdate,v_sysdate);
end if;
----------------opt type 2 for update table--------
if p_opt_type=2 then

update zeven.zeven_venue_type
set   venue_type   =coalesce(p_venue_type,venue_type),
      updated_date =v_sysdate
where zeven_venue_typeid=p_zeven_venue_typeid;
end if;
-----------opt type 3 for delete data from table
if p_opt_type=3 then

   delete from zeven.zeven_venue_type
   where  zeven_venue_typeid=p_zeven_venue_typeid;
end if;


p_ret_type := 1;
exception 
when others then 

p_ret_type := -1;


end;
$$;


--
