-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_gallery_listing_r(numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: u17wc_get_gallery_listing_r(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_gallery_listing_r(p_gallery_type numeric, p_season_id numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_gallery_json jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_gallery_type_filter varchar(100) := ' ';
	v_season_filter varchar(100) := ' ';
    v_count numeric;
    v_gallery_id_arr numeric[];
    v_gallery_json_arr jsonb[];
    v_gallery_json_count numeric;
    v_gallery_json json;
    v_json text := '{"data": [';
    
begin
	
	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    if p_gallery_type is not null then
    	v_gallery_type_filter := ' and gallery_type = $1 ';
    end if;
    
	if p_season_id is not null then
    	v_season_filter := ' and season_id = $2 ';
    end if;
    
    execute 'select count(1)
    			from   u17wc.u17wc_gallery
                where  1 = 1'
                ||v_gallery_type_filter
                ||v_season_filter
	using   p_gallery_type, p_season_id
    into    v_count;
    
    p_count := v_count;
    
    if v_count > 0 then
    	
        execute 'select array(select gallery_id
        						from(select gallery_id, row_number() over(order by created_date desc) rno
                                		from   u17wc.u17wc_gallery
                                        where  status = 1'
                                        ||v_gallery_type_filter
                                        ||v_season_filter
                                        ||
									') tab
								where rno between $3 and $4
								)'
		using   p_gallery_type, p_season_id, v_fromrownumber, v_torownumber
    	into    v_gallery_id_arr;
        
        select array(select row_to_json(row)
                     from(select g.*, (select array_to_json(array_agg(a))
                                       from (select grm.*
                                             from   u17wc.u17wc_gallery_resolution_map grm
                                             where  grm.gallery_id = g.gallery_id
                                            )a
                                      )gallery_resolution
                          from   u17wc.u17wc_gallery g
                          where  g.gallery_id in(select gallery_id
                                                 from   unnest(v_gallery_id_arr) u(gallery_id))
                         ) as row
                     )as data
        into v_gallery_json_arr;
        
        select count(1)
    	into   v_gallery_json_count
    	from   unnest(v_gallery_json_arr) gallery;
     	
     	foreach v_gallery_json in array v_gallery_json_arr
     	loop
     		v_json := v_json||v_gallery_json||',';
  		end loop;
     
     	if v_gallery_json_count > 0 then
     		v_json := substring(v_json,1,(length(v_json)-1));
     	else
     		v_json := substring(v_json,1,(length(v_json)));
     	end if;
     	
     	v_json        := v_json||']}';
     	
        p_gallery_json := v_json::jsonb;
        
    else
    	
        p_gallery_json := '{"data": {}}';
        
    end if;
    
end;

$_$;


--
