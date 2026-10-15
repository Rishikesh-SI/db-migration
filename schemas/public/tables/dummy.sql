-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: dummy
-- Type: TABLE

-- Name: dummy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dummy (
    id integer NOT NULL,
    web_listing_json jsonb,
    asset_guid character varying
);


--
