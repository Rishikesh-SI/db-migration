-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_tb_createdby
-- Type: TABLE

-- Name: zeven_tb_createdby; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_tb_createdby (
    tb_createdbyid numeric NOT NULL,
    item_id numeric,
    user_id numeric,
    is_delete numeric,
    created_date timestamp without time zone,
    created_by numeric,
    updated_date timestamp without time zone,
    updated_by numeric,
    si_client_id numeric
);


--
