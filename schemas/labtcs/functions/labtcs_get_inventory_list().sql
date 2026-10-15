-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_get_inventory_list()
-- Type: FUNCTION

-- Name: labtcs_get_inventory_list(); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_get_inventory_list(OUT p_inventory_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 
declare
v_asics_inventory jsonb;
v_bisleri_inventory jsonb;
begin

select  jsonb_agg(row_to_json(row)) 
		from
		( select gift_id,gift_name,allocated_quantity,available_quantity
		 from labtcs.labtcs_gratification_gift
		 where is_active=1
		 and is_deleted=0
			 ) as row
			into v_asics_inventory;
	
select  jsonb_agg(row_to_json(row)) 
		from
		( select gift_id,gift_name,allocated_quantity,available_quantity
		 from labtcs.labtcs_bisleri_gratification_gift
		 where is_active=1
		 and is_deleted=0
			 ) as row
			into v_bisleri_inventory;		
			
			
			
			select '{"data":' ||string_agg(row_to_json(row)::text,',')||'}'
			from (select v_asics_inventory as asics_inventory,
				  v_bisleri_inventory as bisleri_inventory) as row 
			into p_inventory_json;

end;
$$;


--
