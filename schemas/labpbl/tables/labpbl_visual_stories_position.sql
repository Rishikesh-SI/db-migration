-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_visual_stories_position
-- Type: TABLE

-- Name: labpbl_visual_stories_position; Type: TABLE; Schema: labpbl; Owner: -
--

CREATE TABLE labpbl.labpbl_visual_stories_position (
    id numeric NOT NULL,
    name character varying(2000),
    is_active numeric,
    is_deleted numeric
);


--
