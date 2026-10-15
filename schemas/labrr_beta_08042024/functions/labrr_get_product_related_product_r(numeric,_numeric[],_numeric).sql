-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_product_related_product_r(numeric, numeric[], numeric)
-- Type: FUNCTION

-- Name: labrr_get_product_related_product_r(numeric, numeric[], numeric); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_product_related_product_r(p_product_id numeric, p_entityrole_mapid numeric[], p_cnt numeric, OUT p_productjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	v_asset_typeid numeric := 23 ;
    v_product_upd_date  timestamp;
    v_productid_array numeric[];
    v_sysdate			timestamp;
    v_ent_count			numeric;
    v_prodjson 			text;
    v_ec numeric := p_cnt; -- count of rows required before and after
    v_bc numeric;-- count of rows available before
    v_ac numeric;-- count of rows available after
    v_br numeric:=v_ec;-- count of rows to pull from before
    v_ar numeric:=v_ec;-- count of rows to pull from after
    v_bd numeric;-- less rows in before
    v_ad numeric;-- less rows in after
    
begin

	 v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     select  published_date 
      into   v_product_upd_date
     from   labrr.labrr_product 
     where  product_id = p_product_id
     and is_active = 1 
     and is_deleted = 0 
     and is_published = 1 ;
     
   raise notice 'product_upd_date : %' ,  v_product_upd_date ;
     /*
     select  count(1) into vcount
     from   labrr.labrr_product p 
     where p.published_date < v_product_date     
     and  p.is_active = 1
     and  p.is_deleted = 0
     and  p.is_published = 1
     AND EXISTS (select 1
                 from   labrr.labrr_asset_entity_map eam
                 where  eam.asset_id= p.product_id
                 and    eam.asset_type_id = v_asset_typeid 
                 and    eam.entity_role_map_id in (select unnest(p_entityrole_mapid))
                 GROUP BY eam.asset_id,eam.asset_type_id
                 HAVING COUNT(1)=v_ent_count);
                 
     select  max(published_date) into v_product_maxdate1
     from   labrr.labrr_product p 
     where p.is_active = 1
     and  p.is_deleted = 0
     and  p.is_published = 1
     AND EXISTS (select 1
                 from   labrr.labrr_asset_entity_map eam
                 where  eam.asset_id= p.product_id
                 and    eam.asset_type_id = v_asset_typeid 
                 and    eam.entity_role_map_id in (select unnest(p_entityrole_mapid))
                 GROUP BY eam.asset_id,eam.asset_type_id
                 HAVING COUNT(1) = v_ent_count);
     
     if vcount=0 then 
     
      v_product_date := v_product_maxdate1 ;
      
     end if;
     */
     
      SELECT  
      count(case when p.published_date <= v_product_upd_date then 1 end) count_before,
      count(case when p.published_date > v_product_upd_date then 1 end) count_after
     INTO v_bc, v_ac
     FROM labrr.labrr_product p 
     WHERE p.is_active = 1
     and  p.is_deleted = 0
     and  p.is_published = 1
     and  p.published_date <= v_sysdate
      and p.product_id <> p_product_id
      AND EXISTS (select 1
                  from   labrr.labrr_asset_entity_map eam
                  where  eam.asset_id= p.product_id
                  and    eam.asset_type_id = v_asset_typeid 
                  and    eam.entity_role_map_id in (select unnest(p_entityrole_mapid))
                  GROUP BY eam.asset_id,eam.asset_type_id
                  HAVING COUNT(1) = v_ent_count);

    v_bd:= GREATEST((v_ec-v_bc),0);
    v_ar:= LEAST( (v_ar+v_bd),v_ac);
    
    v_ad:=GREATEST((v_ec-v_ac),0);
    v_br:=LEAST((v_br+v_ad),v_bc);
    
      SELECT array_agg(product_id) into  v_productid_array
      FROM 
        (
            SELECT product_id, 
                  ROW_NUMBER() OVER(PARTITION BY ((case when p.published_date <= v_product_upd_date 
                                                        then 1 
                                                        else 0 end)
                                                   ) ORDER BY p.published_date) rno,
                  ROW_NUMBER() OVER(PARTITION BY ((case when p.published_date <= v_product_upd_date
                                                       then 1 
                                                       else 0 end)
                                                 ) ORDER BY   p.published_date  desc) brno,                                 
                (CASE WHEN p.published_date <= v_product_upd_date THEN 1 ELSE 0 END) is_bef                              
          FROM labrr.labrr_product p
          WHERE p.is_active = 1
          and  p.is_deleted = 0
          and  p.is_published = 1      
          and  p.published_date <= v_sysdate
          and  p.product_id <> p_product_id
          AND EXISTS (select 1
                      from   labrr.labrr_asset_entity_map eam
                      where  eam.asset_id= p.product_id
                      and    eam.asset_type_id = v_asset_typeid 
                      and    eam.entity_role_map_id in (select unnest(p_entityrole_mapid))
                      GROUP BY eam.asset_id,eam.asset_type_id
                      HAVING COUNT(1) = v_ent_count)
        ) all_rel
        WHERE (rno <= v_ar and is_bef = 0) or (brno <= v_br and is_bef = 1) ;
     	
        select array_to_json(array_agg(ab)) , max(cnt)
        into v_prodjson, p_cnt
		from(
                select row_number() over() cnt, p.product_id, p.product_name, p.product_title, p.title_alias, p.product_type_id, 
                       p.available_start_date, p.available_end_date, p.created_date, p.published_date, product_guid, 
                       p.show_in_web, p.show_in_mobile, p.show_in_app, is_active, is_deleted, is_published,
                       row_number()over(order by p.published_date desc) srno,
                       (select array_to_json(array_agg(a)) 
                        from(
                             select asset_entity_map_id, aem.entity_role_map_id, em.entity_name as name,aem.priority,aem.is_visible, aem.is_linkable ,em.canonical_url
                             from labrr.labrr_asset_entity_map aem
                            join labrr.labrr_entity_role_map erm
                            on erm.entity_role_map_id = aem.entity_role_map_id
                            join labrr.labrr_entity_master em
                            on em.entity_master_id = erm.entity_master_id
                             where aem.asset_id = p.product_id
                             and aem.asset_type_id = v_asset_typeid
                           )a
                       )entitydata,
                        (
                           select array_to_json(array_agg(a))
                            from(
                            select  m.product_image_map_id, i.* from labrr.labrr_product_image_map m
                            inner join labrr.labrr_image i 
                            on (m.image_id = i.image_id)
                            where m.product_id = p.product_id
                            )a
                        )imagedata

                from labrr.labrr_product p
                where p.product_id in (select unnest(v_productid_array))
                and is_active = 1 
                and is_deleted = 0 
                and is_published = 1 
                order by srno
            )ab;
        
        p_productjson := ('{ "items" : '||v_prodjson || '}')::json ;
    
end;

$$;


--
