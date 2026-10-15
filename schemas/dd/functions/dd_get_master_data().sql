-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_master_data()
-- Type: FUNCTION

-- Name: dd_get_master_data(); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_master_data(OUT p_result numeric, OUT p_categoryjson jsonb, OUT p_manufacturerjson jsonb, OUT p_attributejson jsonb, OUT p_producttypejson jsonb, OUT p_invmethod_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_category 		text; 
v_manufacturer 	text;
v_attribute   	text;
v_producttype	text;
v_inventorymethod text;

	
    
begin

    select array_to_json(array_agg(a))
	from( select product_category_id, category_name, description, parent_category_id, display_order,price_range,is_show_homepage,is_top_menu,
         		 is_select_pagesize, page_size_option,discount,customer_role_id,limit_per_store,
				created_date, updated_date, created_by, updated_by, category_guid,is_active,is_deleted,is_published 
         from dd.dd_product_category
	 	  where is_active = 1 
	 	  and is_deleted = 0 
	 	  and is_published = 1
        )a
     into v_category; 
     
     p_categoryjson := '{ "category" : '||v_category || '}';
	 
  	select array_to_json(array_agg(a))
	from( select product_manufacturer_id, manufacturer_name, description, display_order,price_range,is_show_homepage,is_top_menu,
         		 is_select_pagesize, page_size_option,discount,customer_role_id,limit_per_store,
				created_date, updated_date, created_by, updated_by, manufacturer_guid,is_active,is_deleted,is_published 
          from dd.dd_product_manufacturer
          where is_active = 1 
          and is_deleted = 0 
          and is_published = 1
       )a
     into v_manufacturer ;
     
     p_manufacturerjson := '{ "manufacturer" : '|| v_manufacturer || '}';
    
    select array_to_json(array_agg(a))
	from( select product_attribute_id, attribute_name, description, created_date, updated_date, created_by, updated_by,
				attribute_guid, is_active, is_deleted, is_published
         from dd.dd_product_attribute
          where is_active = 1 
          and is_deleted = 0 
          and is_published = 1
       )a
     into v_attribute ;
     
     p_attributejson := '{ "attribute" : '|| v_attribute || '}';
     
     select array_to_json(array_agg(a))
	 from( select product_type_id, product_type_name, created_date, updated_date, created_by, updated_by, 
          			product_type_guid, is_active, is_deleted, is_published 
          from dd.dd_product_type
          where is_active = 1 
          and is_deleted = 0 
          and is_published = 1
       )a
     into v_producttype ;
     
     p_producttypejson := '{ "producttype" : '|| v_producttype || '}';
     
     select array_to_json(array_agg(a))
	 from( select * from dd.dd_inventory_method
          where is_active = 1 
          and is_deleted = 0 
          and is_published = 1
       )a
     into v_inventorymethod ;
     
     p_invmethod_json := '{ "inventorymethod" : '|| v_inventorymethod || '}';
     
     
     p_result := 1;
 /*    
exception
	when others then
    		p_result := -1;
    */       
end;

$$;


--
