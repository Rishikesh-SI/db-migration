-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_author_action
-- Type: TABLE

-- Name: pkl_author_action; Type: TABLE; Schema: pkl; Owner: -
--

CREATE TABLE pkl.pkl_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
