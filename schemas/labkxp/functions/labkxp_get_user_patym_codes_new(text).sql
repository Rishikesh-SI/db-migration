-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_get_user_patym_codes_new(text)
-- Type: FUNCTION

-- Name: labkxp_get_user_patym_codes_new(text); Type: FUNCTION; Schema: labkxp; Owner: -
--

CREATE FUNCTION labkxp.labkxp_get_user_patym_codes_new(p_email_id text, OUT p_result numeric, OUT p_output_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_category_id_arr numeric[];
    v_email_id text := upper(p_email_id);
    v_code_id_arr numeric[];
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
begin
	    update labkxp.labkxp_new_email_id
        set status = 1
        where upper(email_id) = upper(p_email_id);
	
    select array(select category_id from labkxp.labkxp_paytm_code_category_master where status = 1) into v_category_id_arr;
	
    if not exists(select 1 from labkxp.labkxp_paytm_code_user_map where email_id = v_email_id and category_id in(select unnest(v_category_id_arr))) then
    	
        select array(select code_id
                     from (select category_id, code_id, row_number() over(partition by category_id order by category_id, code_id) slno
                           from labkxp.labkxp_paytm_code_master
                           where category_id in(select unnest(v_category_id_arr))
                           and status = 0
                          )a
                     where slno = 1)
        into v_code_id_arr;
        
        update labkxp.labkxp_paytm_code_master
        set status = 1
        where code_id in (select unnest(v_code_id_arr))
        and status = 0;
        
		insert into labkxp.labkxp_paytm_code_user_map(code_user_map_id, category_id, code_id, email_id, created_date, status)
        select nextval('labkxp.seq_labkxp_paytm_code_user_map_id'), category_id, code_id, v_email_id, v_current_timestamp, 0
        from labkxp.labkxp_paytm_code_master
        where code_id in (select unnest(v_code_id_arr));
        
        select ('{"data":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
        from (select initcap(tab_d.social_user_name) user_name, tab_b.category_name, tab_c.code_name, tab_c.code, tab_a.code_user_map_id, tab_a.code_id
              from labkxp.labkxp_paytm_code_user_map tab_a
              join labkxp.labkxp_paytm_code_category_master tab_b
              on tab_b.category_id = tab_a.category_id
              join labkxp.labkxp_paytm_code_master tab_c
              on tab_c.code_id = tab_a.code_id
              and tab_c.category_id = tab_b.category_id
              and tab_c.category_id = tab_a.category_id
              join labkxp.labkxp_web_user tab_d
              on tab_d.upper_email_id = tab_a.email_id
              where tab_a.email_id = v_email_id
              and tab_a.status = 0
             )row
		into p_output_json;
        
    	p_result := 1;
        
	else
    	
        p_result := 0;
        
    end if;
    
/*exception
	when others then
    	p_result := -1;*/
end;

$$;


--
