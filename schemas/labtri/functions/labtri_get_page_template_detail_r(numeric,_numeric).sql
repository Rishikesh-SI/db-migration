-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_get_page_template_detail_r(numeric, numeric)
-- Type: FUNCTION

-- Name: labtri_get_page_template_detail_r(numeric, numeric); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_get_page_template_detail_r(p_page_id numeric, p_template_id numeric, OUT p_page_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
v_sysdate date;
begin

 RAISE NOTICE 'Function called with p_page_id: %, p_template_id: %', p_page_id, p_template_id;

if p_page_id is not null
then

RAISE NOTICE 'Querying for page_id: %', p_page_id;

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
	 from labtri.labtri_page_template_detail
	where page_id =p_page_id) as row
	into p_page_json;
	
 RAISE NOTICE 'p_page_id is NULL, skipping page_id query';

end if;	
  if p_template_id is not null
then

 RAISE NOTICE 'Querying for template_id: %', p_template_id;
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
	 from labtri.labtri_page_template_detail
	where template_id =p_template_id) as row
	into p_page_json;
	 RAISE NOTICE 'Data for p_template_id: % retrieved successfully', p_template_id;
end if;	
RAISE NOTICE 'p_template_id is NULL, skipping template_id query';
  END;
$$;


--
