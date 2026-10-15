-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_word_count(numeric, refcursor)
-- Type: FUNCTION

-- Name: lablsg_v1_get_word_count(numeric, refcursor); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_word_count(p_limit numeric, p_word_cnt_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
 

declare
v_time_stamp timestamp :=current_timestamp - interval '10 day';
begin 

open p_word_cnt_cur for select word, count(*) cnt
from (
  select regexp_split_to_table(handle_value, ',') as word
  from lablsg_v1.lablsg_v1_topic
   where created_date >= v_time_stamp
) t
group by word
order by cnt desc

limit coalesce(p_limit,p_limit)
;
end ;

 
$$;


--
