-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_visual_stories_position
-- Type: TABLE

-- Name: labjfc_visual_stories_position; Type: TABLE; Schema: labjfc; Owner: -
--

CREATE TABLE labjfc.labjfc_visual_stories_position (
    id numeric NOT NULL,
    name character varying(2000),
    is_active numeric,
    is_deleted numeric
);


--
