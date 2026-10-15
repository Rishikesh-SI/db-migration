-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_change_asset_lock_status_01082024(character, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labwis_change_asset_lock_status_01082024(character, numeric, numeric, numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_change_asset_lock_status_01082024(p_option character, p_assetid numeric, p_assettypeid numeric, p_userid numeric, OUT p_lockstatus numeric, OUT p_lockedbyid numeric, OUT p_lockedbyname character varying) RETURNS record
    LANGUAGE plpgsql
    AS $_$
 

declare
	v_tablename varchar(10);
    v_columnname varchar(10);
	v_sysdate timestamp := current_timestamp at time zone 'utc';
	v_checked_out_by numeric;
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
	
	execute
	'select checked_out_by from labwis.labwis_'||v_tablename||
	' where '||v_columnname||' = $1;'
	using p_assetid
	into v_checked_out_by;
	
    if p_option = 'u' then
    	if p_userid is not null then
			if v_checked_out_by is  null then 
				execute 'update labwis.labwis_'||v_tablename||
						' set checked_out_by   = '||p_userid||',
						checked_out_date = '''||v_sysdate||'''
						where '||v_columnname||' = '||p_assetid;
			end if;
		end if;
		else
        	execute 'update labwis.labwis_'||v_tablename||
            		' set checked_out_by   = null,
                 	checked_out_date = '''||v_sysdate||'''
				  	where '||v_columnname||' = '||p_assetid;
        end if;
	
    execute 'select case checked_out_by when null then 0 else 1 end, checked_out_by, display_name user_name
    		 from labwis.labwis_'||v_tablename||
             ' left join labwis.labwis_user
              on user_id = checked_out_by'
			 ' where '||v_columnname||' = '||p_assetid
	into    p_lockstatus, p_lockedbyid,p_lockedbyname;
    
end;

 
$_$;


--
