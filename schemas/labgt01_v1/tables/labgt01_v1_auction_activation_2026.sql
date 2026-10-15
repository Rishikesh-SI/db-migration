-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_auction_activation_2026
-- Type: TABLE

-- Name: labgt01_v1_auction_activation_2026; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_auction_activation_2026 (
    id bigint,
    user_guid character varying(2000),
    mobile_number character varying(20),
    scenario_id character varying(2000),
    scenario_text text,
    scenario_position character varying(2000),
    created_at timestamp without time zone,
    count numeric,
    "position" character varying(2000)
);


--
