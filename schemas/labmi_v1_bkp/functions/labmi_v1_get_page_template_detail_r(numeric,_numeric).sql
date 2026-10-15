-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_get_page_template_detail_r(numeric, numeric)
-- Type: FUNCTION

-- Name: labmi_v1_get_page_template_detail_r(numeric, numeric); Type: FUNCTION; Schema: labmi_v1_bkp; Owner: -
--

CREATE FUNCTION labmi_v1_bkp.labmi_v1_get_page_template_detail_r(p_page_id numeric, p_template_id numeric, OUT p_page_json jsonb) RETURNS jsonb
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
	 from labmi_v1.labmi_v1_page_template_detail
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
	 from labmi_v1.labmi_v1_page_template_detail
	where template_id =p_template_id) as row
	into p_page_json;
	
end if;	

  END;
$$;


--
