-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_ins_up_redirect(numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: labmsg_ins_up_redirect(numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: labmsg; Owner: -
--

CREATE FUNCTION labmsg.labmsg_ins_up_redirect(p_asset_id numeric, p_new_title_alias character varying, p_status numeric, p_asset_type numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
    v_alias_number numeric ;
    v_old_title_alias  varchar(4000);
    v_currenttimestamp timestamp;
    v_redirect_id numeric;
    
    v_created_by numeric :=1;
    v_updated_by numeric :=1;
    v_is_active numeric :=1;
    v_is_deleted numeric :=0;
begin

	v_currenttimestamp := current_timestamp at time zone 'utc';
if (p_asset_id is not null and p_status=1)
    then 
           
              
           select title_alias into v_old_title_alias from labmsg.labmsg_asset_list
           where asset_id=p_asset_id
           and asset_type_id=p_asset_type ;
           
           select case when max(alias_number) is null then  0 else max(alias_number) end into v_alias_number 
                  from  labmsg.labmsg_redirect
                  where asset_id=p_asset_id
                  and asset_type_id=p_asset_type;
                  
            v_alias_number:=v_alias_number +1;
            
            if p_new_title_alias <> v_old_title_alias
              then 
              v_redirect_id   := nextval('labmsg.seq_labmsg_redirect_id');
     
                 insert into labmsg.labmsg_redirect(
                                              redirect_id,
                                              old_alias,
                                              new_alias,
                                              asset_id,
                                              asset_type_id,
                                              alias_number,
                                              created_date,
                                              updated_date,
                                              created_by,
                                              updated_by,
                                              is_active,
                                              is_deleted,
                                              is_published,
                                              published_date
                                              )
                                      values(  
                                            v_redirect_id,
                                            v_old_title_alias,
                                            p_new_title_alias,
                                            p_asset_id,
                                            p_asset_type,
                                            v_alias_number,
                                            v_currenttimestamp,
                                            v_currenttimestamp,
                                            v_created_by,
                                            v_updated_by,
                                            v_is_active,
                                            v_is_deleted,
                                            p_status,
                                            v_currenttimestamp
                                             ) ;
                                          
                         end if;             
                                               

end if;

p_result:=1;
exception
	
	when others then
		p_result := -1;

end ;

 $$;


--
