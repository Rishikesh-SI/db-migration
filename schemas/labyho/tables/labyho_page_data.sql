-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_page_data
-- Type: TABLE

-- Name: labyho_page_data; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
