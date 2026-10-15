-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_get_article_data(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labisp_get_article_data(numeric, numeric, numeric); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_get_article_data(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare
	
 
   
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_count numeric;
    
    
begin
     
	 if p_page1_size is null 
     then 
              v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
              v_torownumber   := (p_pagenumber * p_itemnumber);
      else 
          if (p_pagenumber=1) then 
          v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          else 
          v_fromrownumber := p_page1_size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
           end if;
      v_torownumber   := p_page1_size + ( (p_pagenumber-1) * p_itemnumber);
     end if;
   
     
    execute 'select cnt ,''{"data":[''||string_agg((row_to_json(tab))::text,'','')||'']}'' from (select count(1)over() as cnt ,
					row_number()over (order by sl.published_date desc) as rno,
					asset_id,asset_title,title_alias,image_file_name,image_path
    from   labisp.labisp_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.asset_type_id in (1,5) )tab
	where rno between '||v_fromrownumber||' and '||v_torownumber||'
    group by cnt'
    into   p_assetcount,p_assetjson;
    		
exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
 
end;
$_$;


--
