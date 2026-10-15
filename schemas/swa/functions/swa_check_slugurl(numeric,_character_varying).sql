-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_check_slugurl(numeric, character varying)
-- Type: FUNCTION

-- Name: swa_check_slugurl(numeric, character varying); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_check_slugurl(p_assetid numeric, p_slugurl character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
    
    v_slugurl varchar(4000) := upper(p_slugurl);
    
begin
	
    p_result = 0;
    
    if exists(select 1 from swa.swa_asset_list where upper(title_alias) = v_slugurl) then
        p_result = 1;        
    else
        if exists(select 1 from swa.swa_redirect where upper(old_alias) = v_slugurl) then
        	p_result := 1;
		else
            if exists(select 1 from swa.swa_page where upper(alias) = v_slugurl) then
            	p_result := 1;
			else
            	if exists(select 1 from swa.swa_entity_master where upper(substring(canonical_url,2)) = v_slugurl) then
                	p_result := 1;
                end if;
            end if;
        end if;
	end if;
    
exception
	
    when others then
    	p_result := -1;
	
end;

$$;


--
