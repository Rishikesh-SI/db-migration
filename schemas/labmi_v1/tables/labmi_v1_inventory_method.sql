-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_inventory_method
-- Type: TABLE

-- Name: labmi_v1_inventory_method; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_inventory_method (
    inventory_method_id numeric NOT NULL,
    inventory_name character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    im_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
