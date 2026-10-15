-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_bookmark(numeric, numeric, integer)
-- Type: FUNCTION

-- Name: zeven_set_bookmark(numeric, numeric, integer); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_bookmark(p_userid numeric, p_venue_masterid numeric, p_opt_type integer, OUT p_ret numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
v_valid_user numeric = 0;
v_bookmarkid numeric;
v_venue_parentid zeven.zeven_venue_master.venue_parentid%type;
v_sysdate timestamp(0) = current_timestamp;
v_bookmark_exists numeric = 0;
v_user_activity_ret numeric = 0;

begin

  
  select	count(1)
  into    v_valid_user
  from    zeven.zeven_user    
  where   user_id = p_userid;
  
  select  count(1)
  into    v_bookmark_exists
  from    zeven.zeven_venue_bookmark
  where   userid =  p_userid
          and
          venue_masterid = p_venue_masterid;
  
   begin
    select  venue_parentid
    into    v_venue_parentid
    from    zeven.zeven_venue_master
    where   venue_masterid = p_venue_masterid;
  exception 
      when no_data_found then
      v_venue_parentid := 0; 
  end;   
  
  if v_valid_user = 1 then
    if p_opt_type = 1 then
      if v_bookmark_exists = 0 then
        -- v_bookmarkid := zeven.seq_zeven_venue_bookmarkid.nextval;
        select nextval('zeven.seq_zeven_venue_bookmarkid') into v_bookmarkid;
        
        insert into zeven.zeven_venue_bookmark
        ( 
          zeven_venue_bookmarkid,userid,venue_masterid,venue_parentid,created_date,updated_date
        )
        values
        (
          v_bookmarkid,p_userid,p_venue_masterid,v_venue_parentid,v_sysdate,v_sysdate
        );
        
        /* commit; */
        
    perform zeven.zeven_set_user_track_activity( p_userid,0,v_bookmarkid,p_venue_masterid,0,19,0,v_user_activity_ret);
    p_ret := v_user_activity_ret;
        
        p_ret := 1;
      end if;
      else
        p_ret := 2;
    end if;
  
    if p_opt_type = 2 then
      delete
      from   zeven.zeven_venue_bookmark
      where  userid =  p_userid
             and
             venue_masterid = p_venue_masterid;
      
      /* commit; */
      p_ret := 1;
    end if;
  end if;
exception
when others then
  p_ret :=-1111;
  /* rollback; */
  -- raise notice '%','error'||sqlcode||sqlerrm;
end;

$$;


--
