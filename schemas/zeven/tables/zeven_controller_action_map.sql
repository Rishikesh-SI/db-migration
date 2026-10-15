-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_controller_action_map
-- Type: TABLE

-- Name: zeven_controller_action_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_controller_action_map (
    controller_action_map_id numeric NOT NULL,
    controller_id numeric,
    action_id numeric
);


--
