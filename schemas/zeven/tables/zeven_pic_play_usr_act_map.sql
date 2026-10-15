-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_pic_play_usr_act_map
-- Type: TABLE

-- Name: zeven_pic_play_usr_act_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_pic_play_usr_act_map (
    photo_id numeric NOT NULL,
    image_name character varying(100) NOT NULL,
    play_activity_type_id numeric NOT NULL,
    play_activity_ref_id numeric DEFAULT 0,
    facility_id numeric,
    user_id numeric DEFAULT 0,
    is_saved numeric,
    is_deleted numeric,
    is_zeven_published numeric,
    is_published numeric,
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    img_extension character varying(100),
    img_courtesy character varying(200)
);


--
