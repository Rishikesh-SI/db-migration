-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_widget
-- Type: TABLE

-- Name: sibot_widget; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_widget (
    widget_id numeric,
    widget_name text,
    widget_desc text,
    template_id numeric,
    module_id numeric,
    is_custom numeric,
    parent_template_id numeric
);


--
