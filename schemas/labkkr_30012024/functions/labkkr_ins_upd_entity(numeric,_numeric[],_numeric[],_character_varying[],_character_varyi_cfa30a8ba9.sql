-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_ins_upd_entity(numeric, numeric[], numeric[], character varying[], character varying[], numeric[], numeric[], timestamp without time zone[], character varying[], numeric[], character varying[], numeric[], numeric[], numeric[], character varying[], character varying[], numeric[], character varying[], numeric[])
-- Type: FUNCTION

-- Name: labkkr_ins_upd_entity(numeric, numeric[], numeric[], character varying[], character varying[], numeric[], numeric[], timestamp without time zone[], character varying[], numeric[], character varying[], numeric[], numeric[], numeric[], character varying[], character varying[], numeric[], character varying[], numeric[]); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_ins_upd_entity(p_opt_type numeric, p_waf_entity_master_id numeric[], p_client_id numeric[], p_entity_name character varying[], p_entity_display_name character varying[], p_priority numeric[], p_updated_by numeric[], p_date_info timestamp without time zone[], p_city character varying[], p_country numeric[], p_known_as character varying[], p_comp_type numeric[], p_waf_series_master_id numeric[], p_waf_tour_master_id numeric[], p_wafc_entity_name character varying[], p_wafc_entity_display_name character varying[], p_entity_role_id numeric[], p_source_object_id character varying[], p_hyperlink numeric[], OUT p_ret numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_sysdate            timestamp;
     v_entity_master_id	 numeric;
     v_entity_count 	 numeric;
     v_entity_role_map_id numeric;
     v_entity_guid   	 varchar(256);
     /*variable for tags start*/
     v_entity_role_id     numeric;
     v_tagexists		 numeric;
     v_entityexists       numeric;
     /*variable for tags end*/
     
begin
	
     select current_timestamp at time zone 'utc'
     into strict v_sysdate;   
     
     select count(1)
     into   v_entity_count
     from   unnest(p_entity_name)entity_name;
     -- raise notice '%','01'; 
     if p_opt_type = 1 then
     	
          for i in 1..v_entity_count
     	loop
          	
               v_entity_master_id := nextval('labkkr.seq_labkkr_entity_master_id');
          	v_entity_guid := uuid_generate_v4();
          	
          	insert into labkkr.labkkr_entity_master(entity_master_id, waf_entity_master_id, client_id, entity_name, entity_display_name, canonical_url,
                                                 priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted, date_info, city,
                                                 country, known_as, comp_type, waf_series_master_id, waf_tour_master_id, entity_guid, wafc_entity_name,
                                                 wafc_entity_display_name)
          	values
          	(
                   v_entity_master_id, coalesce(p_waf_entity_master_id[i],v_entity_master_id), p_client_id[i], p_entity_name[i], p_entity_display_name[i],
                   null, p_priority[i], v_sysdate, v_sysdate, p_updated_by[i], p_updated_by[i], 1, 0, p_date_info[i], p_city[i], p_country[i],
                   p_known_as[i], p_comp_type[i], p_waf_series_master_id[i], p_waf_tour_master_id[i], v_entity_guid,
                   coalesce(p_wafc_entity_name[i],p_entity_name[i]), coalesce(p_wafc_entity_display_name[i],p_entity_display_name[i])
               );
          	
          	v_entity_role_map_id := nextval('labkkr.seq_labkkr_entity_role_map_id');
			
        		insert into labkkr.labkkr_entity_role_map(entity_role_map_id, entity_role_id, entity_master_id, priority, is_active, source_object_id,
                                                   created_date, updated_date, hyperlink)
          	values
          	(
                   v_entity_role_map_id, p_entity_role_id[i], v_entity_master_id, p_priority[i], 1, p_source_object_id[i], v_sysdate, v_sysdate,
                   p_hyperlink[i]
          	);
          	
    		end loop;
          
          p_ret:=1;
          
	elsif p_opt_type = 2 then
     	-- raise notice '%','1'; 
          v_entity_role_id := 55;
          
          for i in 1..v_entity_count
     	loop
          	
               select count(1)
               into   v_tagexists
               from   labkkr.labkkr_entity_role_map
               where  entity_role_id = 55
               and    entity_master_id in(select entity_master_id
                                          from   labkkr.labkkr_entity_master
                                          where  upper(entity_name) = upper(p_entity_name[i]));
			
               if v_tagexists = 0 then
               	
                    select count(1)
                    into   v_entityexists
                    from   labkkr.labkkr_entity_master
                    where  upper(entity_name) = upper(p_entity_name[i]);
                    
                    if v_entityexists = 0 then
                    	
                         v_entity_master_id := nextval('labkkr.seq_labkkr_entity_master_id');
                         v_entity_guid := uuid_generate_v4();
                         
                         insert into labkkr.labkkr_entity_master(entity_master_id, waf_entity_master_id, client_id, entity_name, entity_display_name, canonical_url,
                                                           priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted, date_info, city,
                                                           country, known_as, comp_type, waf_series_master_id, waf_tour_master_id, entity_guid, wafc_entity_name,
                                                           wafc_entity_display_name)
					values
                         (
                             v_entity_master_id, coalesce(p_waf_entity_master_id[i],v_entity_master_id), p_client_id[i], p_entity_name[i], p_entity_display_name[i],
                             null, p_priority[i], v_sysdate, v_sysdate, p_updated_by[i], p_updated_by[i], 1, 0, p_date_info[i], p_city[i], p_country[i],
                             p_known_as[i], p_comp_type[i], p_waf_series_master_id[i], p_waf_tour_master_id[i], v_entity_guid,
                             coalesce(p_wafc_entity_name[i],p_entity_name[i]), coalesce(p_wafc_entity_display_name[i],p_entity_display_name[i])
                         );
                         
                    end if;
                    
          		v_entity_role_map_id := nextval('labkkr.seq_labkkr_entity_role_map_id');
				
        			insert into labkkr.labkkr_entity_role_map(entity_role_map_id, entity_role_id, entity_master_id, priority, is_active, source_object_id,
                                                        created_date, updated_date, hyperlink)
          		values
          		(
                        v_entity_role_map_id, v_entity_role_id, v_entity_master_id, p_priority[i], 1, p_source_object_id[i], v_sysdate, v_sysdate,
                        p_hyperlink[i]
                    );
                    
                    p_ret:=1;
                    
			else
               	
                    p_ret:=2;
                    
               end if;
          	
    		end loop;
          -- raise notice '%','2'; 
     end if;
     
exception
	
     when others then
		p_ret:=-1;
	
end;

 $$;


--
