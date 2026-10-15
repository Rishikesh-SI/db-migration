-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_download_map
-- Type: TABLE

-- Name: labmi_download_map; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_download_map (
    download_map_id numeric,
    download_id numeric,
    title text,
    description text,
    lang_id numeric,
    file_id numeric,
    file_name text,
    file_size text,
    file_type numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    primary_ent_id numeric,
    secondary_ent_id numeric,
    is_deleted numeric,
    is_active numeric,
    img_height text,
    img_width text,
    file_path text,
    primary_ent_name text,
    secondary_ent_name text,
    pri_canonicle_url character varying(200)
);


--
