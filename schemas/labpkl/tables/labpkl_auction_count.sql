-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_auction_count
-- Type: TABLE

-- Name: labpkl_auction_count; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_auction_count (
    auction_count_id integer NOT NULL,
    asset_id character varying,
    count integer
);


--
