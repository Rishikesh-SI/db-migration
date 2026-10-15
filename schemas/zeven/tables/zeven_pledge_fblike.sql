-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_pledge_fblike
-- Type: TABLE

-- Name: zeven_pledge_fblike; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_pledge_fblike (
    zeven_pledge_fblike_id bigint NOT NULL,
    fb_post_id character varying(500),
    likes bigint,
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active smallint,
    is_deleted smallint
);


--
