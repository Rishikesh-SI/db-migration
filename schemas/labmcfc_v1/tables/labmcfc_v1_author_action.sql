-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_author_action
-- Type: TABLE

-- Name: labmcfc_v1_author_action; Type: TABLE; Schema: labmcfc_v1; Owner: -
--

CREATE TABLE labmcfc_v1.labmcfc_v1_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
