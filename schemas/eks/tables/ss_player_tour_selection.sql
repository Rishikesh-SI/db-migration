-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_player_tour_selection
-- Type: TABLE

-- Name: ss_player_tour_selection; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_player_tour_selection (
    cf_playerid numeric(25,0) NOT NULL,
    cf_tourid numeric(25,0) NOT NULL,
    user_count numeric(38,0) NOT NULL,
    player_count numeric(38,0) NOT NULL,
    selected_percentage numeric(38,2) NOT NULL,
    cf_player_categoryid numeric(5,0)
);


--
