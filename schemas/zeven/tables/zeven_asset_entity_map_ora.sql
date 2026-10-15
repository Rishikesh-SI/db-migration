-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_entity_map_ora
-- Type: TABLE

-- Name: zeven_asset_entity_map_ora; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_asset_entity_map_ora (
    asset_entity_map_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    entity_role_id numeric NOT NULL,
    hidden numeric,
    priority numeric,
    crerated_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_deleted numeric,
    si_client_id numeric NOT NULL
);


--
