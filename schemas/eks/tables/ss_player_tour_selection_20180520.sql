-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_player_tour_selection_20180520
-- Type: TABLE

-- Name: ss_player_tour_selection_20180520; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_player_tour_selection_20180520 (
    cf_playerid numeric(25,0),
    cf_tourid numeric(25,0),
    user_count numeric(38,0),
    player_count numeric(38,0),
    selected_percentage numeric(38,2),
    cf_player_categoryid numeric(5,0)
);


--
