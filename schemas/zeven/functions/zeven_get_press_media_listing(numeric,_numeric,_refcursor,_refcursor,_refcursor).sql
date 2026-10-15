-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_press_media_listing(numeric, numeric, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_press_media_listing(numeric, numeric, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_press_media_listing(p_page_number numeric, p_items_number numeric, p_cur_press_media_cnt refcursor, p_cur_press_media refcursor, p_cur_press_media_pdf refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
v_sql varchar(10000);
v_from_row_number	numeric := 0;
v_to_row_number numeric := 0;

begin

  v_from_row_number := (p_items_number * p_page_number - (p_items_number-1));
	v_to_row_number := (p_items_number * p_page_number);

  v_sql := ' ';
  
  open p_cur_press_media_cnt for select count(1) as cnt from zeven.zeven_press_media;
  
  open p_cur_press_media for select *
                                from  ( select row_number () over ( order by created_date desc ) order_no,
                                               press_media_id,title,short_title,cat_id,image_link,published,is_deleted,created_date,updated_date,created_by,
                                               updated_by,si_client_id,image_zip,imgzipsize
                                        from    zeven.zeven_press_media 
                                      )
                                      data
                                where  order_no between v_from_row_number and v_to_row_number
                                order by created_date desc ;

  open p_cur_press_media_pdf for select  pm.press_media_pdf_map_id,pm.press_media_id,pm.locale_id,l.shortname,l.longname,
                                        pm.pdf_link,published,pm.is_deleted,pm.created_date,pm.updated_date,pm.created_by,
                                        pm.updated_by,pm.si_client_id,pm.pdfsize
                                from    zeven.zeven_press_media_pdf_map  pm
                                inner join (  select press_media_id
                                              from  ( select row_number () over ( order by created_date desc ) order_no,created_date,
                                                             press_media_id
                                                      from   zeven.zeven_press_media 
                                                    )
                                                    data
                                              where  order_no between v_from_row_number and v_to_row_number
                                              order by created_date desc) p
                                        on   pm.press_media_id  = p. press_media_id
                                left join zeven.zeven_locale_master  l
                                      on  l.locale_master_id = pm.locale_id;
                                                          
                    
end;
$$;


--
