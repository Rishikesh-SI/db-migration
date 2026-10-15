-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_ins_upd_web_user_timeline(character varying, numeric, numeric[], jsonb)
-- Type: FUNCTION

-- Name: swa_ins_upd_web_user_timeline(character varying, numeric, numeric[], jsonb); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_ins_upd_web_user_timeline(p_user_guid character varying, p_team_id numeric, p_lang_ent_id numeric[], p_usr_team_json jsonb, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 
	---********************************PREFACE BLOCK*******************************
	--   NAME: _ins_upd_web_user_timeline
	----  Purpose:
	----  Parameters:
	------  External Output:
	------  Written/Modified by:   Date:           Reason:
	--  R. BHATKAR             19/02/2018         CREATION
	--********************************END PREFACE BLOCK***************************
DECLARE
	--REF refcursor;-- Declare a cursor variable
  v_sysdate TIMESTAMP := CURRENT_TIMESTAMP AT TIME ZONE'utc';
  
  v_user_timeline_id numeric;
  v_entity_role_map_id numeric[];
  
  v_asset_count jsonb;
  v_category_cur jsonb;
  v_listing_asset_count numeric;
  v_listing_asset_json jsonb;
  v_json jsonb;
  v_asset_count_str text;
  v_user_id numeric;
  
   v_usr_team_json jsonb;
  v_fev_team_id numeric;
  p_result numeric;
  
BEGIN
select user_id into v_user_id
from swa.swa_web_user
where user_guid=p_user_guid;

IF
	NOT EXISTS ( SELECT 1 FROM swa.swa_web_user_timeline WHERE web_user_guid=p_user_guid ) THEN
	
	v_user_timeline_id :=nextval('swa.seq_swa_user_timeline_id');
	
	
	
INSERT INTO swa.swa_web_user_timeline ( user_timeline_id,
	                                    web_user_id, 
									    fev_team_id, 
									    web_usr_team, 
									    created_by, 
									    updated_by, 
									    created_date, 
									    updated_date, 
									    is_active ,
									    web_user_guid
									   )
	                   VALUES
								(v_user_timeline_id,
								v_user_id,
								p_team_id,
								p_usr_team_json,
								v_user_id,
								v_user_id,
								v_sysdate,
								v_sysdate,
								1,
								p_user_guid
                                 ) 
								;
                   p_result := 1;
	 ELSE 
	 
	 
    select web_usr_team ,fev_team_id into v_usr_team_json ,v_fev_team_id 
      from swa.swa_web_user_timeline where web_user_guid=p_user_guid ;
      
       if  (p_team_id is not null )
       then 
        update swa.swa_web_user_timeline
        set     fev_team_id=p_team_id,  
		           updated_date=v_sysdate
        where web_user_guid=p_user_guid ;
        ELSIF    (p_team_id is null )
             then 
                update swa.swa_web_user_timeline
                set     web_usr_team =p_usr_team_json,
		                    updated_date=v_sysdate
                where   web_user_guid=p_user_guid;
        
        
        end if
        ;
	 
      p_result := 1;
	END IF;
	
	 
--exception when others 
   --  then p_result:=-1;
	
	/* v_json := '{
                			"data" :{
							       "user_id" : "'||coalesce(v_user_id::text, '')||'",
								   "user_guid" : "'||coalesce(p_user_guid, '')||'",
                            	   "Fev_Team_id" : "'||coalesce(p_team_id::text, '')||'",
								    "teams":'||trim(trailing '}' from trim(leading '{' from p_usr_team_json::text))
								||'} }
                                 
				}';*/
                
	
    v_json := '{"data":{"user_id":"'||coalesce(v_user_id::text, '')||'",
    					          "user_guid":"'||coalesce(p_user_guid, '')||'",
                        "status":"'||coalesce(p_result::text, '')||'",
                        "Fev_Team_id":"'||coalesce(p_team_id::text, '')||'",
                        "teams":'||p_usr_team_json::text||'}}';
    
	 p_json := v_json::jsonb;
--OPEN REF FOR SELECT * FROM swa.swa_web_user_timeline WHERE web_user_id = p_user_id;-- Open the second cursor
--RETURN REF;

END;

$$;


--
