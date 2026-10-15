-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_get_page_template_detail_r(numeric, numeric)
-- Type: FUNCTION

-- Name: labkkr_v1_get_page_template_detail_r(numeric, numeric); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_get_page_template_detail_r(p_page_id numeric, p_template_id numeric, OUT p_page_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
v_sysdate date;
begin

if p_page_id is not null
then
select row_to_json(row)::jsonb 
from(select page_id,
	 page_alias,
	 template_id,
	 template_name,
	 template_html,
	 page_info_json,
	 is_updated,
	 mobile_html,
	 mobile_page_json,
	 is_responsive,
	 is_amp,
	 is_deleted,
	 is_published
	 from labkkr_v1.labkkr_v1_page_template_detail
	where page_id =p_page_id) as row
	into p_page_json;
	
end if;	
 

  if p_template_id is not null
then
select jsonb_agg(row) 
from(select page_id,
	 page_alias,
	 template_id,
	 template_name,
	 template_html,
	 page_info_json,
	 is_updated,
	 mobile_html,
	 mobile_page_json,
	 is_responsive,
	 is_amp,
	 is_deleted,
	 is_published
	 from labkkr_v1.labkkr_v1_page_template_detail
	where template_id =p_template_id) as row
	into p_page_json;
	
end if;	

  END;
$$;


--
