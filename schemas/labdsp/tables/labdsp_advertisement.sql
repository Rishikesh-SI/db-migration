-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_advertisement
-- Type: TABLE

-- Name: labdsp_advertisement; Type: TABLE; Schema: labdsp; Owner: -
--

CREATE TABLE labdsp.labdsp_advertisement (
    ad_id numeric NOT NULL,
    ad_title text NOT NULL,
    ad_code text NOT NULL,
    ad_position numeric NOT NULL,
    is_published numeric NOT NULL,
    is_trashed numeric NOT NULL,
    published_version_number numeric NOT NULL,
    published_date timestamp without time zone,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    ad_guid character varying(256) NOT NULL,
    is_default numeric NOT NULL,
    ad_client numeric[],
    is_detail numeric,
    is_external numeric
);


--
