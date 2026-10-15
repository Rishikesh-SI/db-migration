-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_invite
-- Type: TABLE

-- Name: zeven_invite; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_invite (
    invite_id numeric NOT NULL,
    from_user_id numeric,
    to_user_id numeric,
    facility_id numeric,
    sport_id numeric,
    message character varying(200),
    is_accepted numeric,
    invitee_message character varying(200),
    invite_date character varying(20),
    invite_time character varying(20),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone
);


--
