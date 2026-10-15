-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_inventory_list()
-- Type: FUNCTION

-- Name: dd_get_inventory_list(); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_inventory_list(OUT p_inventory_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

begin

select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
		from
		( select gift_id,gift_name,allocated_quantity,available_quantity
		 from dd.dd_gratification_gift
		 where is_active=1
		 and is_deleted=0
		 order by gift_id
			 ) as row
			into p_inventory_json;

end;
$$;


--
