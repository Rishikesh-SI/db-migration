-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_story
-- Type: TABLE

-- Name: zeven_user_story; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_user_story (
    zeven_user_story_id numeric NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50),
    phone_no character varying(15) NOT NULL,
    email_id character varying(100) NOT NULL,
    city character varying(50),
    dob timestamp(0) without time zone,
    sports_played character varying(2000),
    twitter_id character varying(2000),
    photos character varying(2000),
    videos character varying(2000),
    achivements character varying(2000),
    story character varying(2000),
    created_date timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_date timestamp(0) without time zone DEFAULT now() NOT NULL,
    is_active numeric DEFAULT 1 NOT NULL,
    is_deleted numeric DEFAULT 0 NOT NULL,
    facebook_id character varying(2000),
    google_id character varying(2000)
);


--
