-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_invitation_listing(text, text, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: stn_get_invitation_listing(text, text, numeric, numeric, numeric); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_invitation_listing(p_email_id text, p_mobile_no text, p_page_number numeric, p_item_number numeric, p_page_1_size numeric, OUT p_invitation_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_from_row_number numeric;
	v_to_row_number numeric;
	v_count numeric;
	v_email_id text := upper(trim(p_email_id));
	v_mobile_no text := trim(p_mobile_no);
	
begin
	
	if p_page_1_size is null then
		v_from_row_number := ((p_page_number * p_item_number) - (p_item_number - 1));
		v_to_row_number := (p_page_number * p_item_number);
	else
		if p_page_number = 1 then
			v_from_row_number := ((p_page_number * p_item_number) - (p_item_number - 1));
		else
			v_from_row_number := p_page_1_size + (((p_page_number - 1) * p_item_number) - (p_item_number - 1));
		end if;
   		v_to_row_number := p_page_1_size + ((p_page_number - 1) * p_item_number);
	end if;
	
	select count(1)
	into v_count
	from stn.stn_invitation i
	where ((i.email_id = v_email_id and i.mobile_no = v_mobile_no) or (i.email_id = v_email_id) or (i.mobile_no = v_mobile_no))
	and not exists(select 1 from stn.stn_invitation i1 where i1.invitation_id = i.invitation_id and status = 1);
	
	if v_count > 0 then
		
		select ('{"data":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
		from(select *
			from(select *, row_number() over(order by i.created_date desc) slno
				from stn.stn_invitation i
				where ((i.email_id = v_email_id and i.mobile_no = v_mobile_no) or (i.email_id = v_email_id) or (i.mobile_no = v_mobile_no))
				and not exists(select 1 from stn.stn_invitation i1 where i1.invitation_id = i.invitation_id and status = 1)
				)tab
			where slno between v_from_row_number and v_to_row_number
			)row
		into p_invitation_json;
		
		p_result := 1;
		
	else
		
		p_invitation_json := '{"data":[]}'::jsonb;
		
		p_result := 0;
		
	end if;
	
exception
	when others then
		p_invitation_json := '{"data":[]}'::jsonb;
		p_result := -1;
	
end;

$$;


--
