-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_display_report(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: spz_display_report(numeric, numeric, numeric); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_display_report(p_page_flag numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_count numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
begin

    -- page_falg =4 means careers
	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber := (p_pagenumber * p_itemnumber);
    select count(1) into p_count from spz.spz_contact where page_flag=p_page_flag;
    select ('{"data":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb into p_json
    from (select 
contact_id,name,
email_address,mobile_number,feedback,dob,gender,created_date
,row_number() over(order by created_date desc) slno,
(select array_agg(row_to_json(tab)) from ( select image_id as id ,image_path  as file_path ,
                                          image_file_name as file_name from spz.spz_image 
                                          where image_id  = ANY (string_to_array(attachment,',')::int[]))tab) files
           from spz.spz_contact 
		  where  page_flag=p_page_flag order by created_date desc               
	     )row
	where slno between v_fromrownumber and v_torownumber;
    if p_count = 0 then
    	p_json := ('{"data":["data not available "]}')::jsonb;
    end if;
end;

$$;


--
