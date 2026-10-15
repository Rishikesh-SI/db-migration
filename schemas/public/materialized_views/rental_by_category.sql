-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: rental_by_category
-- Type: MATERIALIZED VIEW

-- Name: rental_by_category; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.rental_by_category AS
 SELECT sibot_application_logs.log_id,
    sibot_application_logs.function_name,
    sibot_application_logs.application_id,
    sibot_application_logs.json_input,
    sibot_application_logs.create_date
   FROM sibot.sibot_application_logs
  ORDER BY sibot_application_logs.log_id
  WITH NO DATA;


--
