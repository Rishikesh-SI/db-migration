-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_inventory_method
-- Type: TABLE

-- Name: labmi_inventory_method; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_inventory_method (
    inventory_method_id numeric NOT NULL,
    inventory_name character varying NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    im_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
