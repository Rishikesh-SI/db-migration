-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_product_details_r(character varying, character varying, numeric)
-- Type: FUNCTION

-- Name: labmi_get_product_details_r(character varying, character varying, numeric); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_product_details_r(p_title_alias character varying, p_userguid character varying, p_opttype numeric, OUT p_result numeric, OUT p_productjson jsonb, OUT p_nextprevjson jsonb, OUT p_entityjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_fromrownumber numeric;
v_torownumber numeric ;
    v_json  jsonb ;
    v_sku_json  text ;
    v_product_shipping text ;
    v_customizejson text ;
    v_attributejson  text ;
    v_asset_type_id numeric := 23;
    v_entityjson text ;
    v_imagejson text ;
    v_review text;
    v_entityrole_mapid numeric[];
    v_productid numeric;
    v_usercart_json text;
    v_product_rating numeric(5,0);
    v_prod_review_count numeric(5,0);
v_product_draft_count numeric;
begin
   
    select product_id, product_json into v_productid, v_json
    from labmi.labmi_product
where title_alias = p_title_alias
    and is_active = 1
    and is_deleted = 0
    and is_published = 1;
   
    select avg(rating) , count(1)  into v_product_rating, v_prod_review_count
    from labmi.labmi_product_review
    where product_id = v_productid
    and is_active = 1
    and is_deleted = 0;
   
    v_json := jsonb_set(v_json,'{data,product_rating}', coalesce(v_product_rating,0)::text::jsonb, true);  
    v_json := jsonb_set(v_json,'{data,product_review_count}', coalesce(v_prod_review_count,0)::text::jsonb, true);
   
    select array_agg(entity_role_map_id) into v_entityrole_mapid
    from labmi.labmi_asset_entity_map
    where asset_type_id = v_asset_type_id
    and asset_id = v_productid;
   
     select  '[' || string_agg('{"skudata" : ' || skudata,'},')|| '}]' into v_sku_json
     from (

        select row_to_json(a)::text as skudata -- array_to_json(array_agg(a)) into v_sku_json
        from (
           select product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata::jsonb, inventory_method_id,
                product_inventory_id, stock_quantity, (string_agg(attribute1, ','))::jsonb specification,
                attribute_specification_ids,display_order
           from (
           select product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id,
                product_inventory_id, stock_quantity , attribute_specification_ids,pas.display_order,
          '{"attribute" : [{'|| string_agg('"attribute_specification_id" :'|| product_attribute_specification_id::text
                                           ||', "specification_name" : "'|| specification_name
                                           ||'", "specification_code" : "'|| specification_code
                                           ||'", "attribute_name" : "'
                                           || attribute_name ||'" ' ,'},{')||'}]}' attribute1

           from
           (
            select s.product_sku_id, s.product_id, s.sku_code,unnest(s.attribute_specification_ids)specification_id, s.product_price,
                  s.is_customize, s.sku_guid, s.sku_json->'skudata'->>'imagedata' imagedata, s.attribute_specification_ids::text,
                i.inventory_method_id, i.product_inventory_id, i.stock_quantity                      
            from labmi.labmi_product_sku s
            inner join labmi.labmi_product_inventory i
             on (s.product_sku_id = i.product_sku_id)              
            where s.product_id = v_productid
            and s.is_active = 1
            and s.is_deleted = 0
            and i.is_active = 1
            and i.is_deleted = 0
             and i.stock_quantity <>0  
           )spc
           inner join labmi.labmi_product_attribute_specification pas
           on (spc.specification_id = pas.product_attribute_specification_id)
           inner join labmi.labmi_product_attribute pa
           on (pas.product_attribute_id = pa.product_attribute_id)
           where spc.stock_quantity > 0
           group by product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id,
                product_inventory_id, stock_quantity, -- pa.attribute_name,
               attribute_specification_ids,pas.display_order

           )abc
           group by product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id,
                product_inventory_id, stock_quantity, attribute_specification_ids,display_order
        order by display_order asc
)a
     )ab;
   
   
    v_json := jsonb_set(v_json,'{data,skujson}', v_sku_json::jsonb, true);    
   
   select array_to_json(array_agg(ab)) into v_customizejson
   from (
           select row_to_json(a) as data --'"data" : '|| row_to_json(a) data1
           from (select m.product_id, m.product_customize_map_id, m.customize_price, m.is_added_price,
                   m.pcm_guid, m.product_customize_id, c.customize_name  
            from labmi.labmi_product_customize c
            inner join labmi.labmi_product_customize_map m
            on (c.product_customize_id = m.product_customize_id)
            where  m.product_id = v_productid
             and is_deactivated =1
      )a
     )ab ;
     
     v_json := jsonb_set(v_json,'{data,customizejson}', coalesce(v_customizejson,'null')::jsonb, true);
     
    select array_to_json(array_agg(row)) into v_entityjson
    from(
         select asset_entity_map_id, aem.entity_role_map_id, em.entity_name as name,aem.priority,aem.is_visible, aem.is_linkable ,em.canonical_url
         from labmi.labmi_asset_entity_map aem
        join labmi.labmi_entity_role_map erm
        on erm.entity_role_map_id = aem.entity_role_map_id
        join labmi.labmi_entity_master em
        on em.entity_master_id = erm.entity_master_id
         where aem.asset_id = v_productid
         and aem.asset_type_id = v_asset_type_id
    )row;
   
    v_json := jsonb_set(v_json,'{data,entitydata}', coalesce(v_entityjson,'null')::jsonb, true);
   
    select array_to_json(array_agg(row)) into v_imagejson
    from(
        select row_to_json (a) as data
        from(
        select  m.product_image_map_id, i.* from labmi.labmi_product_image_map m
        inner join labmi.labmi_image i
        on (m.image_id = i.image_id)
        where m.product_id = v_productid
            and m.is_active=1
        )a
    )row;  
   
    v_json := jsonb_set(v_json,'{data,imagejson}', coalesce(v_imagejson,'null')::jsonb, true);
   
     select  '[' ||string_agg(data1::text,',') ||']'  
     into v_attributejson
     from (
            select ('{"'||attribute_name ||'" : [{'
                    || string_agg('"product_attribute_specification_id" :'
                    || product_attribute_specification_id::text ||',"specification_name" : "'
                    || specification_name ||'","specification_code" : "'
                    || specification_code ,'"},{')||'"}]}')::json as data1
            from
            (
             select  abc.product_id, unnest(abc.attribute_specification_ids) specid
             from
               (select  s.product_id, s.attribute_specification_ids , i.stock_quantity                
                from labmi.labmi_product_sku s
                inner join labmi.labmi_product_inventory i
                on (s.product_sku_id = i.product_sku_id)              
                where s.product_id = v_productid
                and s.is_active = 1
                and s.is_deleted = 0
                and i.is_active = 1
                and i.is_deleted = 0
               
              )abc
          -- where abc.stock_quantity > 0
            )ab
            inner join labmi.labmi_product_attribute_specification  s
            on (s.product_attribute_specification_id = ab.specid)
            inner join labmi.labmi_product_attribute a
            on (a.product_attribute_id = s.product_attribute_id)
            group by  attribute_name  
          )pas
        ;
   
    -- v_attributejson := ' "attributejson" : '|| v_attributejson ||'';
     
     v_json := jsonb_set(v_json,'{data, attributejson}', coalesce(v_attributejson,'null')::jsonb, true);
     
     
    -- v_json := jsonb_set(v_json,'{data, attributejson}', v_attributejson::jsonb, true);
     
     
         select array_to_json(array_agg(a))  
         into v_review
         from
         (select r.product_review_id, r.product_id, r.user_id, r.customer_email_id,
r.review_title, r.review_text, r.rating, r.is_approved--,
                 -- u.user_full_name                  
            from labmi.labmi_product_review  r
           -- inner join labmi.labmi_web_user u
           -- on (r.user_id = u.user_id)
            where product_id = v_productid
            and r.is_active = 1
            and r.is_deleted = 0
          order by r.review_date desc
    )a ;
     
     v_json := jsonb_set(v_json,'{data, reviewjson}', coalesce(v_review,'null')::jsonb, true);
   
    select  '[' || string_agg('{"usercart" : ' || skudata,'},')|| '}]' into v_usercart_json
     from (

        select row_to_json(a)::text as skudata
        from (
           select product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata::jsonb, inventory_method_id,
                product_inventory_id, stock_quantity, (string_agg(attribute1, ','))::jsonb specification,
                attribute_specification_ids, user_id, user_cart_guid, user_emailid
           from (
           select product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id,
                product_inventory_id, stock_quantity , attribute_specification_ids, user_id, user_cart_guid, user_emailid,
          '{"attribute" : [{'|| string_agg('"attribute_specification_id" :'|| product_attribute_specification_id::text
                                           ||', "specification_name" : "'|| specification_name
                                           ||'", "specification_code" : "'|| specification_code
                                           ||'", "attribute_name" : "'
                                           || attribute_name ||'" ' ,'},{')||'}]}' attribute1

           from
           (
           select s.product_sku_id, s.product_id, s.sku_code,unnest(s.attribute_specification_ids)specification_id, s.product_price,
                  s.is_customize, s.sku_guid, s.sku_json->'skudata'->>'imagedata' imagedata, s.attribute_specification_ids::text,
                  pc1.user_id, pc1.user_cart_guid, pc1.user_emailid,
                  i.inventory_method_id, i.product_inventory_id, i.stock_quantity - coalesce(sum(cd.quantity),0) stock_quantity
               
               -- s.sku_json->'skudata'->>'inventory_method_id' inventory_method_id,        
              from labmi.labmi_product_sku s
              inner join labmi.labmi_product_inventory i
              on (s.product_sku_id = i.product_sku_id)
              inner join labmi.labmi_product_cart_details pcd
              on (s.product_sku_id = pcd.product_sku_id)
              inner join labmi.labmi_product_cart pc1
              on (pcd.product_cart_id = pc1.product_cart_id)
              left join ( select d.* from labmi.labmi_product_cart_details d                                
               inner join labmi.labmi_product_cart pc
                on (d.product_cart_id = pc.product_cart_id
                               and pc.payment_gateway_redirect_url = 'true'
                  and pc.payment_status = 1)
            ) cd  on (cd.product_sku_id = s.product_sku_id)
              where s.product_id = v_productid
              and coalesce(pc1.payment_gateway_redirect_url,'') not in ('true','false')
              and pc1.payment_status != 1
              and pc1.user_cart_guid = p_userguid
              group by s.product_sku_id, s.product_id, s.sku_code, s.attribute_specification_ids::text, s.product_price,
                  s.is_customize, pc1.user_id, pc1.user_cart_guid, pc1.user_emailid,
                       s.sku_guid, s.sku_json->'skudata'->>'imagedata', i.inventory_method_id, i.product_inventory_id,
                i.stock_quantity
           )spc
           inner join labmi.labmi_product_attribute_specification pas
           on (spc.specification_id = pas.product_attribute_specification_id)
           inner join labmi.labmi_product_attribute pa
           on (pas.product_attribute_id = pa.product_attribute_id)
           -- where spc.stock_quantity > 0
           group by product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id,
                product_inventory_id, stock_quantity, user_id, user_cart_guid, user_emailid, -- pa.attribute_name,
               attribute_specification_ids

           )abc
           group by product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id,
                product_inventory_id, stock_quantity, attribute_specification_ids, user_id, user_cart_guid, user_emailid
         

)a
     )ab;
       
    v_json := jsonb_set(v_json,'{data,usercartdata}', coalesce(v_usercart_json,'""')::jsonb, true);
   
    v_json := jsonb_set(v_json,'{data,is_login_user}', coalesce(p_opttype::text,'""')::jsonb, true);
     

select  labmi.labmi_get_product_cart_count(p_userguid) into v_product_draft_count ;

   

 v_json := jsonb_set(v_json,'{data,product_draft_count}', coalesce(v_product_draft_count::text,'""')::jsonb, true);
 
     p_productjson := v_json;      
         
     p_entityjson := ('{ "entities" : '|| v_entityjson || '}')::jsonb;
   
   select * into p_nextprevjson from labmi.labmi_get_product_related_product_r(v_productid, v_entityrole_mapid, 10);
   
p_result := 1;  
/*
 exception
     when others then
      p_productcount := -1;
          p_productjson  := '{"items":[]}';
 */
end;

$$;


--
