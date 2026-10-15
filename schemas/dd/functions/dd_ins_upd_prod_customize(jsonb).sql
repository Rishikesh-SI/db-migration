-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_ins_upd_prod_customize(jsonb)
-- Type: FUNCTION

-- Name: dd_ins_upd_prod_customize(jsonb); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_ins_upd_prod_customize(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								json;
v_product_customize_id				numeric;
v_customize_name 					character varying;
v_desc								character varying;
v_product_id						numeric;
v_sysdate 							timestamp;
v_created_by 						numeric;
V_updated_by						numeric;
V_is_active							numeric;
V_is_deleted						numeric;
V_is_published						numeric;
V_customize_guid					character varying;
v_customize							jsonb;
v_price								numeric;
v_is_added_price					numeric;
v_custmize_prize numeric;

BEGIN

		select current_timestamp
		into   v_sysdate;
		
		 v_customize := p_json;   
		    
				
    select v_customize->'customize'->>'product_customize_id', 
          -- v_customize->'customize'->>'product_id',
           v_customize->'customize'->>'customize_name', 
           v_customize->'customize'->>'description',
          -- v_customize->'customize'->>'price',
          -- v_customize->'customize'->>'is_added_price',					   
           v_customize->'customize'->>'is_published',
           v_customize->'customize'->>'is_deleted',
           v_customize->'customize'->>'is_active',
		   v_customize->'customize'->>'custmize_prize'

    into   v_product_customize_id, 
        --	v_product_id, 
            v_customize_name, 
            v_desc,
        --	v_price,
        --	v_is_added_price,
            V_is_published,							
            V_is_deleted,
            V_is_active,
			v_custmize_prize;                
                
        if v_product_customize_id is null then

            v_product_customize_id  := nextval('dd.seq_dd_product_customize_id');
            V_customize_guid := uuid_generate_v4();

            insert into dd.dd_product_customize
            (product_customize_id, customize_name, description, -- price, product_id, is_added_price, 
             created_date, updated_date, 
            created_by, updated_by, customize_guid, is_active, is_deleted, is_published,custmize_prize)
            values
            (v_product_customize_id, v_customize_name, v_desc, -- v_price, v_product_id, v_is_added_price,
             v_sysdate, v_sysdate, 1, 1, V_customize_guid, V_is_active, V_is_deleted, V_is_published ,v_custmize_prize);

        else

            update dd.dd_product_customize
            set customize_name = v_customize_name, 
                description = v_desc, 
            --	price = v_price, 
            --	product_id = v_product_id, 
            --	is_added_price = v_is_added_price,						
                updated_date = v_sysdate, 
                updated_by = 1, 						
                is_active = V_is_active , 
                is_deleted = V_is_deleted, 
                is_published = V_is_published,
				custmize_prize=v_custmize_prize
            where product_customize_id = v_product_customize_id ;

        end if;     

  

p_result := 1 ; 

p_data := v_customize;
 
 Exception 
  when others then 
  	p_result := -1 ; 
    p_data := '{}';
        

END;

    

$$;


--
