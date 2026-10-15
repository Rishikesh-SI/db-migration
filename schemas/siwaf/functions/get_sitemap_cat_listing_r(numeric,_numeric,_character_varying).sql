-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_sitemap_cat_listing_r(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: _get_sitemap_cat_listing_r(numeric, numeric, character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_sitemap_cat_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_cient_code character varying, OUT p_count numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_sysdate timestamp:= current_timestamp at time zone 'utc';
begin
	
	 
	 
	/*if p_pagenumber is not null and p_itemnumber is not null then
		if p_page1_size is null then
			v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
			v_torownumber := (p_pagenumber * p_itemnumber);
		else
			if p_pagenumber = 1 then
				v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          	else
          		v_fromrownumber := p_page1_size + ((((p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
          	end if;
   			v_torownumber := p_page1_size + ((p_pagenumber-1) * p_itemnumber);
		end if;
	end if;
*/
	execute 'select cnt ,(''{"items":''||jsonb_agg(tab)::text||''}'')::jsonb
	            from (
				select count(1)over() as cnt ,
					a.*,
					coalesce(is_checked,0) as is_checked
    			from siwaf.siwaf_sitemap_category a
				left join siwaf.siwaf_client_sitemap_category_map b 
				on b.sitemap_category_id=a.category_id
				and b.client_code=$1
    			 )tab
				 group by cnt'
    into   p_count,p_json
	using  p_cient_code
    ;
   
/*exception
	when others then
     	p_count := -1;
          p_json := '{"items":[{"error":"no record"}]}';
  */
end;
$_$;


--
