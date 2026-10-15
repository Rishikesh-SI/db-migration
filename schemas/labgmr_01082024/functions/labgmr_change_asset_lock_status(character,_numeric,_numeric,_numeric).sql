-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_change_asset_lock_status(character, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labgmr_change_asset_lock_status(character, numeric, numeric, numeric); Type: FUNCTION; Schema: labgmr_01082024; Owner: -
--

CREATE FUNCTION labgmr_01082024.labgmr_change_asset_lock_status(p_option character, p_assetid numeric, p_assettypeid numeric, p_userid numeric, OUT p_lockstatus numeric, OUT p_lockedbyid numeric, OUT p_lockedbyname character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	v_tablename varchar(10);
    v_columnname varchar(10);
	v_sysdate timestamp := current_timestamp at time zone 'utc';
begin
	
    case p_assettypeid
    	when 1 then
        	v_tablename := 'article';
            v_columnname := 'article_id';
        when 2 then
        	v_tablename := 'album';
            v_columnname := 'album_id';
        when 4 then
        	v_tablename := 'video';
            v_columnname := 'video_id';
        when 5 then
        	v_tablename := 'topic';
            v_columnname := 'topic_id';
        when 6 then
        	v_tablename := 'poll';
            v_columnname := 'poll_id';
	end case;
	
    if p_option = 'u' then
    	if p_userid is not null then
        	execute 'update labgmr.labgmr_'||v_tablename||
            		' set checked_out_by   = '||p_userid||',
                 	checked_out_date = '''||v_sysdate||'''
				  	where '||v_columnname||' = '||p_assetid;
		else
        	execute 'update labgmr.labgmr_'||v_tablename||
            		' set checked_out_by   = null,
                 	checked_out_date = '''||v_sysdate||'''
				  	where '||v_columnname||' = '||p_assetid;
        end if;
    end if;
	
    execute 'select case checked_out_by when null then 0 else 1 end, checked_out_by, display_name user_name
    		 from labgmr.labgmr_'||v_tablename||
             ' left join labgmr.labgmr_user
              on user_id = checked_out_by'
			 ' where '||v_columnname||' = '||p_assetid
	into    p_lockstatus, p_lockedbyid,p_lockedbyname;
    
end;

 $$;


--
