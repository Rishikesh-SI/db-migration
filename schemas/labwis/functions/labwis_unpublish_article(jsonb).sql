-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_unpublish_article(jsonb)
-- Type: FUNCTION

-- Name: labwis_unpublish_article(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_unpublish_article(p_data jsonb, OUT p_result numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_article_id numeric;
v_status     numeric;
begin 
	select p_data->'data'->>'article_id' ,
		   p_data->'data'->>'status'
	into  v_article_id,
		  v_status;
	
		  
	if(v_article_id is not null  and v_status = 2) then
	
		update  labwis.labwis_asset_list
		set is_published = 0 , is_trashed = 1
		where asset_type_id = 1 and asset_id = v_article_id;
		
		update  labwis.labwis_asset_entity_map
		set is_published = 0
		where asset_type_id = 1 and asset_id = v_article_id;
		
		update  labwis.labwis_article_asset_map
		set is_published = 0
		where asset_type_id = 1 and article_id = v_article_id;
		
		update  labwis.labwis_article
		set is_published = 0 , is_trashed = 1
		where article_id = v_article_id;
		p_result := 1;
	else 
		p_result := 0;

	end if;
		p_json := p_data;
	
end ;
$$;


--
