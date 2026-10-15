-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_advertisement
-- Type: TABLE

-- Name: labmsg_advertisement; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_advertisement (
    ad_id numeric NOT NULL,
    ad_title text,
    ad_code text,
    ad_position numeric,
    is_published numeric,
    is_trashed numeric,
    published_version_number numeric,
    published_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    ad_guid character varying(256),
    is_default numeric,
    ad_client numeric[],
    is_detail numeric,
    is_external numeric
);


--
