-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_template_component_data_23022026
-- Type: TABLE

-- Name: labgt_template_component_data_23022026; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_template_component_data_23022026 (
    template_id numeric,
    template_component_map_id numeric,
    component_id numeric,
    req_entity numeric[],
    other_entity numeric[],
    exclude_entity numeric[],
    tagged_entity numeric[],
    widget_data jsonb,
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    web_item_number numeric,
    mob_item_number numeric,
    page_id numeric,
    page_entity numeric[],
    page_alias character varying(1000),
    selector character varying(1000),
    is_responsive numeric,
    fetch_from numeric,
    page_req_entity numeric[],
    is_fallback numeric,
    is_mobile numeric,
    is_amp numeric,
    parent_tcmap_id numeric
);


--
