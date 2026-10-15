-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_redirect
-- Type: TABLE

-- Name: labkkr_v1_redirect; Type: TABLE; Schema: labkkr_v1; Owner: -
--

CREATE TABLE labkkr_v1.labkkr_v1_redirect (
    redirect_id numeric NOT NULL,
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
