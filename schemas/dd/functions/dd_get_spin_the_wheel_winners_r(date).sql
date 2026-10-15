-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_spin_the_wheel_winners_r(date)
-- Type: FUNCTION

-- Name: dd_get_spin_the_wheel_winners_r(date); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_spin_the_wheel_winners_r(p_date date, OUT p_winner_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare 
begin
select  '{"data":'||array_to_json(array_agg(row_to_json(row)))||'}'
from (
select u.first_name,u.last_name,u.email_id,
g.gift_name
from dd.dd_web_user u
join dd.dd_daily_gratification_winners gw
on gw.user_id=u.user_id
join dd.dd_gratification_gift g
on g.gift_id=gw.gift_id
where gw.created_date::date=p_date) row
into p_winner_json ;

 
end;
$$;


--
