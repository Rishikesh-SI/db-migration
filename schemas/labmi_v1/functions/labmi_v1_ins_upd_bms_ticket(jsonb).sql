-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_ins_upd_bms_ticket(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_ins_upd_bms_ticket(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_ins_upd_bms_ticket(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare

     v_json jsonb;
     v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
     v_bkg character varying;
	 v_app_name character varying;
	 v_event_title character varying;
	 v_venue_name character varying;
	 v_trans_date timestamp without time zone;
	 v_show_date timestamp without time zone;
	 v_ticket_qty numeric;
	 v_ticket_amt numeric;
	 v_ticket_price numeric;
	 v_category character varying;
	 v_payment_mode character varying;
	 v_customer_mail_id character varying;
	 v_customer_mobile_number character varying;
	 v_status character varying;
	 v_add_info jsonb;
	 i jsonb;
     
begin
	FOR i IN SELECT * FROM json_array_elements(p_json::json->'data')
	loop
		--raise notice '%',i;
		 select i->>'appName',
			    i->>'bookingId',
				i->>'venueName',
				i->>'eventName',
				i->>'showDateTime',
				i->>'transactionDateTime',
				i->>'totalTicketQuantity',
				i->>'ticketPrice',
				i->'totalTicketAmount',
				i->>'categoryName',
				i->>'emailId',
				i->>'mobileNumber', 
                i->>'paymentStatus',                 
                i

		into   v_app_name,
				v_bkg,
				v_venue_name,
				v_event_title,
				v_show_date,
				v_trans_date,
				v_ticket_qty,
				v_ticket_price,
				v_ticket_amt,
				v_category,
                v_customer_mail_id,
                v_customer_mobile_number,
                v_status,
                v_json;

		if not exists(select 1 from labmi_v1.labmi_v1_bms_booking where bkg_id = v_bkg)then --and app_name = v_app_name

            INSERT INTO labmi_v1.labmi_v1_bms_booking(
            bkg_id, app_name, venue_name, event_title, trans_date, show_date, ticket_qty, ticket_amt, ticket_price, category, payment_mode, customer_mail_id, customer_mobile_number, status, add_info, created_date, is_used)
            values(v_bkg,v_app_name,v_venue_name,v_event_title,v_trans_date,v_show_date,v_ticket_qty,v_ticket_amt,v_ticket_price,v_category,v_payment_mode,v_customer_mail_id,v_customer_mobile_number,v_status,v_json,v_currenttimestamp,0);

        else

            update labmi_v1.labmi_v1_bms_booking set 
            app_name=v_app_name,
            venue_name=v_venue_name,
            event_title=v_event_title,
            trans_date=v_trans_date,
            show_date=v_show_date,
            ticket_qty=v_ticket_qty,
            ticket_amt=v_ticket_amt,
            ticket_price=v_ticket_price,
            category=v_category,
            payment_mode=v_payment_mode,
            customer_mail_id=v_customer_mail_id,
            customer_mobile_number=v_customer_mobile_number,
            status=v_status,
            add_info=v_json,
            created_date=v_currenttimestamp,
            is_used=0
            where bkg_id=v_bkg;

		
		end if;
		
	end loop;
     p_result:=1;

end;
$_$;


--
