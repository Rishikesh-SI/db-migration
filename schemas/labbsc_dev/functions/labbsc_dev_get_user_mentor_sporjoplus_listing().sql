-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_mentor_sporjoplus_listing()
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_mentor_sporjoplus_listing(); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_mentor_sporjoplus_listing(OUT p_user_listing_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
begin
select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
from (
select c.user_id,u.first_name,u.last_name,c.updated_date as payment_date,c.cart_id,
	uu.display_name as mentor_name,da.merchant_name
from labbsc_dev.labbsc_dev_cart c
join labbsc_dev.labbsc_dev_web_user u
on u.user_id=c.user_id
left join labbsc_dev.labbsc_dev_user_mentor_mapping um
	on um.user_id=c.user_id
	and um.cart_id=c.cart_id
left join labbsc_dev.labbsc_dev_user uu
	on uu.user_id=um.mentor_id
left join labbsc_dev.labbsc_dev_journey_activity da
	on c.activity_id = da.activity_id
where c.activity_id in (16,17,18)
and c.status=2
order by c.updated_date desc) row
into p_user_listing_json
;
  
end;
$$;


--
