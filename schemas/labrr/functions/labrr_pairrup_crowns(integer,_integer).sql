-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_pairrup_crowns(integer, integer)
-- Type: FUNCTION

-- Name: labrr_pairrup_crowns(integer, integer); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_pairrup_crowns(p_level integer, p_moves integer) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $$
    select case
             when p_moves <  t.pairs           then null   -- fewer moves than pairs is impossible
             when p_moves <= t.three_crown_max then 3
             when p_moves <= t.two_crown_max   then 2
             else 1
           end
    from (values
            -- level, pairs, max moves for 3 crowns, max moves for 2 crowns
            (1,  8, 16, 23),   -- Royal Icons
            (2, 10, 20, 29),   -- Rajasthan Heritage
            (3, 12, 24, 35),   -- Match Day
            (4, 12, 24, 35)    -- The Squad
         ) as t(level_no, pairs, three_crown_max, two_crown_max)
    where t.level_no = p_level;
$$;


--
