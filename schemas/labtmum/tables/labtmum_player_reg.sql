-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: labtmum_player_reg
-- Type: TABLE

-- Name: labtmum_player_reg; Type: TABLE; Schema: labtmum; Owner: -
--

CREATE TABLE labtmum.labtmum_player_reg (
    player_id numeric,
    first_name character varying(1000),
    middle_name character varying(1000),
    last_name character varying(1000),
    player_json jsonb,
    guid text,
    created_date date,
    asset_type_id numeric,
    image_ratio text,
    image_size text,
    image_width text
);


--
