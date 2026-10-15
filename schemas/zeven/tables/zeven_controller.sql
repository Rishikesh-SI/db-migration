-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_controller
-- Type: TABLE

-- Name: zeven_controller; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_controller (
    controller_id numeric NOT NULL,
    controller_name character varying(500),
    si_client_id numeric(10,0)
);


--
