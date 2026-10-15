-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_get_word_count(numeric, refcursor)
-- Type: FUNCTION

-- Name: labgrl_get_word_count(numeric, refcursor); Type: FUNCTION; Schema: labgrl; Owner: -
--

CREATE FUNCTION labgrl.labgrl_get_word_count(p_limit numeric, p_word_cnt_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
 

declare
v_time_stamp timestamp :=current_timestamp - interval '10 day';
begin 

open p_word_cnt_cur for select word, count(*) cnt
from (
  select regexp_split_to_table(handle_value, ',') as word
  from labgrl.labgrl_topic
   where created_date >= v_time_stamp
) t
group by word
order by cnt desc

limit coalesce(p_limit,p_limit)
;
end ;

 
$$;


--
