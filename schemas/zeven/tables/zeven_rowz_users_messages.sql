-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_rowz_users_messages
-- Type: TABLE

-- Name: zeven_rowz_users_messages; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_rowz_users_messages (
    users_messages_id numeric NOT NULL,
    user_id numeric,
    ambassador_id numeric,
    message character varying(140),
    is_accepted numeric,
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric
);


--
