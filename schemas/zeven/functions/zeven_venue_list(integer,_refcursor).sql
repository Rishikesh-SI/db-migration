-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_venue_list(integer, refcursor)
-- Type: FUNCTION

-- Name: zeven_venue_list(integer, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_venue_list(p_opt_type integer, p_cur_venue_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
----********************************preface block*******************************
----  name:   zeven.zvn_venue_list
----
----  parameters:  
----
----
----  external output:  
----                    
----
----  written/modified:   date:           reason:
----  s.sarkar           24/11/2015      creation
----********************************end preface block***************************
begin


 if p_opt_type = 1 then
    open p_cur_venue_list for
      select      venue_masterid,
                  venue_name,
                  venue_type,
                  address,
                  latitude,
                  longitude
      from  zeven.zeven_venue_master
      where   is_active = 1
      and     venue_type = 1;
  end if;

 if p_opt_type = 2 then
    open p_cur_venue_list for
      select           vm1.venue_masterid,
                  vm1.venue_name,
                  vm1.venue_type,
                  vm.address,
                  vm.latitude,
                  vm.longitude
      from  zeven.zeven_venue_master vm
      inner join zeven.zeven_venue_master vm1
      on vm.venue_masterid = vm1.venue_parentid
      where   vm1.is_active = 1
      and     vm1.venue_type = 2;
  end if;
  
end;
$$;


--
