-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_auction_activation_2026
-- Type: TABLE

-- Name: labgt_auction_activation_2026; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_auction_activation_2026 (
    id bigint NOT NULL,
    user_guid character varying(2000),
    mobile_number character varying(20),
    scenario_id character varying(2000) NOT NULL,
    scenario_text text,
    scenario_position character varying(2000),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    count numeric,
    "position" character varying(2000)
);


--
