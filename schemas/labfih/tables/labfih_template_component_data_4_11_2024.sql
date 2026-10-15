-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_template_component_data_4_11_2024
-- Type: TABLE

-- Name: labfih_template_component_data_4_11_2024; Type: TABLE; Schema: labfih; Owner: -
--

CREATE TABLE labfih.labfih_template_component_data_4_11_2024 (
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
