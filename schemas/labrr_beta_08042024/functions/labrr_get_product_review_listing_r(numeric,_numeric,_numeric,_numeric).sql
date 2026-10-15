-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_product_review_listing_r(numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labrr_get_product_review_listing_r(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_product_review_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_product_id numeric, OUT p_reviewcount numeric, OUT p_reviewjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
		v_json text;
        v_fromrownumber numeric;
        v_torownumber numeric;
	
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
    
    select array_to_json(array_agg(a)) , max(review_count)
    into  v_json , p_reviewcount
    from 
    (   select * from 
        (
            select r.product_review_id, r.product_id, r.user_id, 
																					r.customer_email_id, r.review_title, r.review_text, r.rating, r.is_approved,
                   row_number() over(order by r.review_date desc) srno,
																					
                   count(1) over() review_count
            from labrr.labrr_product_review  r 
            
            where product_id = p_product_id
            and r.is_active = 1 
            and r.is_deleted = 0 
        )ab
        where ab.srno between v_fromrownumber and v_torownumber
    )a; 
     
    p_reviewjson := ('{ "data" : '|| v_json::text || '}' )::json;
   
    
/* 
 exception
     when others then
      	p_productcount := -1;
          p_productjson  := '{"items":[]}';
 */ 
end;

$$;


--
