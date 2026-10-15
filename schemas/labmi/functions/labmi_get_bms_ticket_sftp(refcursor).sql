-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_bms_ticket_sftp(refcursor)
-- Type: FUNCTION

-- Name: labmi_get_bms_ticket_sftp(refcursor); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_bms_ticket_sftp(p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare

begin

open p_user_cursor for
SELECT bkg_id as bookingId, app_name as appName, venue_name as venueName, 
event_title as eventName, trans_date as transactionDateTime, show_date as showDateTime,
ticket_qty as totalTicketQuantity, ticket_amt as totalTicketAmount,
ticket_price as ticketPrice, category as categoryName, customer_mail_id as emailId, 
customer_mobile_number as mobileNumber,status as paymentStatus,
 add_info->>'seatInfo' as seatInfo,
add_info->>'firstName' as firstName,add_info->>'lastName' as lastName,
add_info->>'hdPinCode' as hdPinCode,add_info->>'address' as address,
add_info->>'city' as city,add_info->>'state' as state
FROM labmi.labmi_bms_booking WHERE is_used=0;	
	
end;

$$;


--
