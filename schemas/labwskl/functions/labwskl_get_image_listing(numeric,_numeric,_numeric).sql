-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_get_image_listing(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labwskl_get_image_listing(numeric, numeric, numeric); Type: FUNCTION; Schema: labwskl; Owner: -
--

CREATE FUNCTION labwskl.labwskl_get_image_listing(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_result numeric, OUT p_imagecount numeric, OUT p_imagejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$ 

declare
	
    	v_fromrownumber numeric;
    	v_torownumber numeric;
     v_imagejsonarr jsonb[];
     v_imagejson jsonb;
     v_json text := '{"items":[';
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
     
     select count(*)
     from   labwskl.labwskl_image
     where  is_active    = 1
     and    is_deleted   = 0
     and    is_published = p_status
     into   p_imagecount;
     
     execute 'select array(select row_to_json(row) as jsonrow
                  from(select slno, image_id, image_caption, image_path, image_file_name, title_alias
                       from (select row_number() over(order by created_date desc) slno, image_id, image_caption, image_path, image_file_name, title_alias
                             from   labwskl.labwskl_image
                             where  is_active    = 1
                             and    is_deleted   = 0
                             and    is_published = ' || p_status || ' )tab
                       where slno between '||'$1'||' and '||'$2'||'
                      )
                  row)'
     into   v_imagejsonarr
     using  v_fromrownumber, v_torownumber;
     
     foreach v_imagejson in array v_imagejsonarr
     loop
     	
          v_json := v_json||v_imagejson||',';
          
     end loop;
     
     v_json := substring(v_json,1,(length(v_json)-1));
     
     v_json := v_json||']}';
     
     p_imagejson  := v_json::jsonb;
     
     p_result := 1;

exception
	
     when others then
     	
          p_result := -1;
          p_imagejson := '{"items":[]}';

end;

 $_$;


--
