-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: labwafdemo_get_page_widget_data_r(jsonb)
-- Type: FUNCTION

-- Name: labwafdemo_get_page_widget_data_r(jsonb); Type: FUNCTION; Schema: labwafdemo; Owner: -
--

CREATE FUNCTION labwafdemo.labwafdemo_get_page_widget_data_r(p_in_json jsonb, OUT p_widget_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
 v_page_id numeric;
 v_template_component_map_id numeric;
 v_template_id numeric;
 v_required_entities numeric[];
 v_page_required_entities numeric[];
 v_is_amp numeric;
 v_is_mob numeric;
 
 /*
 {
  "page_id": 781,
  "template_component_map_id": 13322,
  "required_entities": [
    4,
    8,
    282
  ],
  "page_required_entities": [
    4,
    8
  ]
}*/
begin

select p_in_json->>'page_id',
       p_in_json->>'template_component_map_id',
	   p_in_json->>'is_mobile',
	   p_in_json->>'is_amp'
	   
	   into
	   v_page_id,
	   v_template_component_map_id,
	   v_is_mob,
	   v_is_amp;
	   
	 
	 
	 select widget_data 
	 from labwafdemo.labwafdemo_template_component_data
	 where   page_id=v_page_id
	and template_component_map_id=v_template_component_map_id
	 and is_amp= coalesce(v_is_amp,is_amp)
	  and is_mobile= coalesce(v_is_amp,is_mobile)
	  into p_widget_json;
	 
	 exception when others then
	 p_widget_json:='{}';

end;
$$;


--
