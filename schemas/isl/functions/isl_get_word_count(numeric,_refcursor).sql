-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_word_count(numeric, refcursor)
-- Type: FUNCTION

-- Name: isl_get_word_count(numeric, refcursor); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_word_count(p_limit numeric, p_word_cnt_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$     

declare
v_time_stamp timestamp :=current_timestamp - interval '10 day';
begin 

open p_word_cnt_cur for SELECT word, count(*) cnt
FROM (
  SELECT regexp_split_to_table(handle_value, ',') as word
  FROM isl.isl_TOPIC
   where created_date >= v_time_stamp
) t
GROUP BY word
order by cnt desc

limit coalesce(p_limit,p_limit)
;
end ;

     $$;


--
