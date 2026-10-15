-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_tour
-- Type: TABLE

-- Name: ss_tour; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_tour (
    cf_tourid numeric(25,0) NOT NULL,
    tour_name character varying(255) NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    team_player_count numeric(10,0) NOT NULL,
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    max_player_cat numeric(5,0),
    player_display_flag numeric
);


--
