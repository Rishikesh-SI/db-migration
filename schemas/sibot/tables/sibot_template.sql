-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_template
-- Type: TABLE

-- Name: sibot_template; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_template (
    template_id numeric,
    template_name text,
    template_desc text,
    template_json jsonb
);


--
