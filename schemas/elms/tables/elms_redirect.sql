-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: elms
-- Object: elms_redirect
-- Type: TABLE

-- Name: elms_redirect; Type: TABLE; Schema: elms; Owner: -
--

CREATE TABLE elms.elms_redirect (
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
