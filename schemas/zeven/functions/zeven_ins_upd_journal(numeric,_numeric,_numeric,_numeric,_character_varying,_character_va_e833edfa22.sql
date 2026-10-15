-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_upd_journal(numeric, numeric, numeric, numeric, character varying, character varying, numeric, timestamp without time zone, character varying)
-- Type: FUNCTION

-- Name: zeven_ins_upd_journal(numeric, numeric, numeric, numeric, character varying, character varying, numeric, timestamp without time zone, character varying); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_upd_journal(p_opt_type numeric, p_journal_id numeric, p_user_id numeric, p_sport_id numeric, p_duration character varying, p_venue_name character varying, p_venue_id numeric, p_journal_date timestamp without time zone, p_note character varying, OUT p_ret numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
--********************************preface block*******************************
--  name:   zeven.zvn_ins_upd_journal
--
--  parameters:  
--
--
--  external output:  
--                    
--
--  written/modified:   date:           reason:
--  s.sarkar          19/11/2015      creation
--********************************end preface block***************************
v_user_id numeric;
v_journal_id numeric;
v_user_activity_ret numeric = 0;

begin


  select count(1) into v_user_id
  from zeven.zeven_web_user
  where user_id = p_user_id;

  if v_user_id > 0 then
  
      if p_opt_type = 1 then
        
        v_journal_id := nextval('zeven.seq_zvn_user_journal_id');
        
        insert into zeven.zeven_user_journal
        (
          journal_id,user_id,sport_id,duration,venue_id,venue_name,journal_date,note,created_date,is_delete
        )
        values
        (
          v_journal_id,p_user_id,p_sport_id,p_duration,p_venue_id,p_venue_name,p_journal_date,p_note,current_timestamp,0
        );
        
       /* commit; */ 
      
    perform zeven.zvn_set_user_track_activity(p_user_id,0,v_journal_id,coalesce(p_venue_id,0),0,16,0,v_user_activity_ret);
    p_ret := v_user_activity_ret;
      
      p_ret := v_journal_id;   
      end if;
      
      if p_opt_type = 2 then
        
        update zeven.zeven_user_journal
        set   sport_id = p_sport_id,
              duration = p_duration,
              updated_date = current_timestamp,
              venue_id   = p_venue_id,
              venue_name = p_venue_name,
              journal_date = p_journal_date,
              note = p_note
        where journal_id = p_journal_id 
        and   user_id = p_user_id;
        
        /* commit; */
        
        p_ret := 2;
      end if;
      
       if p_opt_type = 3 then
       
          update zeven.zeven_user_journal
          set    is_delete = 1,
                 updated_date = current_timestamp
          where  journal_id = p_journal_id 
          and   user_id = p_user_id;
          
          /* commit; */
          
         p_ret := 3; 
       end if; 
   
   else 
   p_ret := -1;
   end if;
    
exception
when others then
  p_ret:=-2;
  /* rollback; */
end;
$$;


--
