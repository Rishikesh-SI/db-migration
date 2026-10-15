-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_article_ingestion_audit
-- Type: TABLE

-- Name: labtri_article_ingestion_audit; Type: TABLE; Schema: labtri; Owner: -
--

CREATE TABLE labtri.labtri_article_ingestion_audit (
    id integer DEFAULT nextval('labtri.labtri_article_ingestion_audit_id_seq'::regclass) NOT NULL,
    title_alias character varying(4000),
    article_id numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    processed_at date NOT NULL,
    payload jsonb NOT NULL,
    status text,
    operation character varying(100)
);


--
