-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: archive_old_data()
-- Type: FUNCTION

-- Name: archive_old_data(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.archive_old_data() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Move data (example: older than 30 days)
    INSERT INTO orders_replica
    SELECT *
    FROM orders
    WHERE created_at::date < '2026-05-01';

    -- Delete moved data
    DELETE FROM orders
    WHERE created_at::date < '2026-05-01';

END;
$$;


--
