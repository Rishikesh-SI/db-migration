-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_get_image_listing(numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: pbl_get_image_listing(numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_get_image_listing(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchwords character varying, OUT p_result numeric, OUT p_imagecount numeric, OUT p_imagejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_fromrownumber numeric;
     v_torownumber numeric;
     -- v_imagejsonarr jsonb[];
     v_imagejsonarr text ;
     v_imagejson jsonb;
   --  v_json text := '{"items":[';
     v_searchwords varchar(4000);
     v_searchquery varchar(4000) := ' ';
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
     
    if p_searchwords is not null then
     	
     	v_searchwords := p_searchwords;
          
          v_searchwords:='*'|| replace(''||v_searchwords||'',' ',':* & *') ||':*';
          v_searchquery := ' and ( to_tsvector( image_caption) @@@ to_tsquery( '''||v_searchwords||''') 
          					OR   to_tsvector( image_desc) @@@ to_tsquery( '''||v_searchwords||'''))';
		
     end if;
     
     execute ' select count(*)
     from   pbl.pbl_image
     where  is_active    = 1
     and    is_deleted   = 0
     and    is_published = ' || p_status || ' '
      || v_searchquery || ' '     
     into   p_imagecount;
     
    /*   
     execute 'select array(select row_to_json(row) as jsonrow
                  from(select slno, image_id, image_caption, image_path, image_file_name, title_alias
                       from (select row_number() over(order by created_date desc) slno, image_id, image_caption, image_path, image_file_name, title_alias
                             from   pbl.pbl_image
                             where  is_active    = 1
                             and    is_deleted   = 0
                             and    is_published = ' 
                             || p_status || ' '
                             || v_searchquery || '
                             )tab
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
     */
     
     execute 'select string_agg(jsonrow::text,'','')
     from (select row_to_json(row) as jsonrow
                  from(select slno, image_id, image_caption, image_path, image_file_name, title_alias
                       from (select row_number() over(order by created_date desc) slno, image_id, image_caption,
                       		 image_path, image_file_name, title_alias
                             from   pbl.pbl_image
                             where  is_active    = 1
                             and    is_deleted   = 0
                             and    is_published = ' 
                             || p_status || ' '
                             || v_searchquery || '
                             )tab
                       where slno between '||'$1'||' and '||'$2'||'
                      )
                  row)a'
     into   v_imagejsonarr
     using  v_fromrownumber, v_torownumber;
     
    -- raise notice ' :  %',  ('{"items":[' ||v_imagejsonarr ||']}');
           
     p_imagejson  := ('{"items":[' ||v_imagejsonarr ||']}')::jsonb;
     
     p_result := 1;

exception
	
     when others then
     	
          p_result := -1;
          p_imagejson := '{"items":[]}';

end;

$_$;


--
