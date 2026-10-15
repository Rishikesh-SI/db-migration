-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_cat_role_map
-- Type: TABLE

-- Name: zeven_cat_role_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_cat_role_map (
    cat_role_map_id numeric NOT NULL,
    cat_id numeric NOT NULL,
    entity_role_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    si_client_id numeric NOT NULL
);


--
