-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_asset_ingestion_audit
-- Type: TABLE

-- Name: labuww_asset_ingestion_audit; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_asset_ingestion_audit (
    id bigint DEFAULT nextval('labuww.labuww_asset_ingestion_audit_id_seq'::regclass) NOT NULL,
    asset_id numeric,
    asset_type numeric NOT NULL,
    title_alias character varying(4000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    payload jsonb,
    status character varying(1000),
    operation character varying(100),
    processed_at date
);


--
