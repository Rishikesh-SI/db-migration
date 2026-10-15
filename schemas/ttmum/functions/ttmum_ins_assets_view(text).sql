-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_ins_assets_view(text)
-- Type: FUNCTION

-- Name: ttmum_ins_assets_view(text); Type: FUNCTION; Schema: ttmum; Owner: -
--

CREATE FUNCTION ttmum.ttmum_ins_assets_view(p_titlealias text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
	v_assetid numeric;
    v_assettypeid numeric;
    
begin
	
	if p_titlealias is not null then
    	
        select asset_id, asset_type_id
        into strict v_assetid, v_assettypeid
        from ttmum.ttmum_asset_list
        where title_alias = p_titlealias;
        
        -- if (round(random()*10)) = 1 then
        	insert into ttmum.ttmum_assets_view
    		select nextval('ttmum.seq_ttmum_assets_view_id'),v_assetid,v_assettypeid,current_timestamp at time zone 'utc',1;
        -- end if;
        
        p_result := 1;
        
	else
    	
    	p_result := 0;
        
    end if;
    
exception
	when others then
    	p_result := -1;
end;

$$;


--
