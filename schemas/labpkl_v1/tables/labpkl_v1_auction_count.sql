-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_auction_count
-- Type: TABLE

-- Name: labpkl_v1_auction_count; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_auction_count (
    auction_count_id integer NOT NULL,
    asset_id character varying,
    count integer
);


--
