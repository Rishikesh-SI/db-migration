-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_site_config_parameter
-- Type: TABLE

-- Name: abp_site_config_parameter; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_site_config_parameter (
    site_config_parameter numeric NOT NULL,
    parameter_name text NOT NULL,
    parameter_value text NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL
);


--
