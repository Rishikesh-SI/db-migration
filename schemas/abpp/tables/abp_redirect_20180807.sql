-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_redirect_20180807
-- Type: TABLE

-- Name: abp_redirect_20180807; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_redirect_20180807 (
    redirect_id numeric,
    old_alias character varying(4000),
    new_alias character varying(4000),
    asset_id numeric,
    asset_type_id numeric,
    alias_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone
);


--
