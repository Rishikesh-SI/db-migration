-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_ins_upd_entity_ar(numeric, numeric[], numeric[], character varying[], character varying[], numeric[], numeric[], timestamp without time zone[], character varying[], numeric[], character varying[], numeric[], numeric[], numeric[], character varying[], character varying[], numeric[], character varying[], numeric[])
-- Type: FUNCTION

-- Name: labkc_v1_ins_upd_entity_ar(numeric, numeric[], numeric[], character varying[], character varying[], numeric[], numeric[], timestamp without time zone[], character varying[], numeric[], character varying[], numeric[], numeric[], numeric[], character varying[], character varying[], numeric[], character varying[], numeric[]); Type: FUNCTION; Schema: labkc_v1_bkp; Owner: -
--

CREATE FUNCTION labkc_v1_bkp.labkc_v1_ins_upd_entity_ar(p_opt_type numeric, p_waf_entity_master_id numeric[], p_client_id numeric[], p_entity_name character varying[], p_entity_display_name character varying[], p_priority numeric[], p_updated_by numeric[], p_date_info timestamp without time zone[], p_city character varying[], p_country numeric[], p_known_as character varying[], p_comp_type numeric[], p_waf_series_master_id numeric[], p_waf_tour_master_id numeric[], p_wafc_entity_name character varying[], p_wafc_entity_display_name character varying[], p_entity_role_id numeric[], p_source_object_id character varying[], p_hyperlink numeric[], OUT p_ret numeric, OUT p_entityjson jsonb) RETURNS record
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
     v_entityjsonarr      jsonb[];
     v_entityjson         jsonb;
     v_json			 text := '{"content":{"entities":[';
     
begin
	
     select current_timestamp at time zone 'utc'
     into strict v_sysdate;
     
     create temp table if not exists v_entities
     (
         t_entity_master_id numeric
     );
     
     select count(1)
     into   v_entity_count
     from   unnest(p_entity_name)entity_name;
     
     if p_opt_type = 1 then
     	
          for i in 1..v_entity_count
     	loop
          	
               v_entity_master_id := nextval('labkc_v1.seq_labkc_v1_entity_master_id');
          	v_entity_guid := uuid_generate_v4();
          	
          	insert into labkc_v1.labkc_v1_entity_master(entity_master_id, waf_entity_master_id, client_id, entity_name, entity_display_name, canonical_url,
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
          	
          	v_entity_role_map_id := nextval('labkc_v1.seq_labkc_v1_entity_role_map_id');
			
        		insert into labkc_v1.labkc_v1_entity_role_map(entity_role_map_id, entity_role_id, entity_master_id, priority, is_active, source_object_id,
                                                   created_date, updated_date, hyperlink)
          	values
          	(
                   v_entity_role_map_id, p_entity_role_id[i], v_entity_master_id, p_priority[i], 1, p_source_object_id[i], v_sysdate, v_sysdate,
                   p_hyperlink[i]
          	);
               
               insert into v_entities
               values(v_entity_master_id);
          	
    		end loop;
          
          p_ret:=1;
          
	elsif p_opt_type = 2 then
     	
          v_entity_role_id := 55;
          
          for i in 1..v_entity_count
     	loop
          	
               select count(1)
               into   v_tagexists
               from   labkc_v1.labkc_v1_entity_role_map
               where  entity_role_id = 55
               and    entity_master_id in(select entity_master_id
                                          from   labkc_v1.labkc_v1_entity_master
                                          where  upper(entity_name) = upper(p_entity_name[i]));
			
               if v_tagexists = 0 then
               	
                    select count(1)
                    into   v_entityexists
                    from   labkc_v1.labkc_v1_entity_master
                    where  upper(entity_name) = upper(p_entity_name[i]);
                    
                    if v_entityexists = 0 then
                    	
                         v_entity_master_id := nextval('labkc_v1.seq_labkc_v1_entity_master_id');
                         v_entity_guid := uuid_generate_v4();
                         
                         insert into labkc_v1.labkc_v1_entity_master(entity_master_id, waf_entity_master_id, client_id, entity_name, entity_display_name, canonical_url,
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
                    
          		v_entity_role_map_id := nextval('labkc_v1.seq_labkc_v1_entity_role_map_id');
				
        			insert into labkc_v1.labkc_v1_entity_role_map(entity_role_map_id, entity_role_id, entity_master_id, priority, is_active, source_object_id,
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
               
               insert into v_entities
               values(v_entity_master_id);
          	
    		end loop;
          
     end if;
     
     select array(select row_to_json(row) as jsonrow
                  from(select e.t_entity_master_id as entity_master_id, erm.entity_role_map_id, er.entity_role_id, et.entity_type_id,
                       et.entity_type_name, eg.entity_group_id, eg.group_name
                       from   v_entities e
                       join   labkc_v1.labkc_v1_entity_role_map erm
                       on     erm.entity_master_id = e.t_entity_master_id
                       join   labkc_v1.labkc_v1_entity_role er
                       on     er.entity_role_id = erm.entity_role_id
                       join   labkc_v1.labkc_v1_entity_type et
                       on     et.entity_type_id = er.entity_type_id
                       join   labkc_v1.labkc_v1_entity_group eg
                       on     eg.entity_group_id = er.entity_group_id
                      ) row
                 )
	into   v_entityjsonarr;
     
     select count(1)
    	into   v_entity_count
    	from   unnest(v_entityjsonarr) entity_id;
     
     foreach v_entityjson in array v_entityjsonarr
     loop
     	v_json := v_json||v_entityjson||',';
  	end loop;
     
     if v_entity_count > 0 then
     	v_json := substring(v_json,1,(length(v_json)-1));
     else
     	v_json := substring(v_json,1,(length(v_json)));
     end if;
     
     v_json        := v_json||']}}';
     p_entityjson  := v_json::jsonb;
     
     drop table v_entities;
     
/*exception
	
     when others then
		p_ret:=-1;
          p_entityjson := '{"content":{"entities":[]}}';*/
	
end;

 $$;


--
