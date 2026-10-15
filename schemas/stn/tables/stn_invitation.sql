-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_invitation
-- Type: TABLE

-- Name: stn_invitation; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_invitation (
    invitation_id numeric NOT NULL,
    email_id character varying(100) NOT NULL,
    mobile_no character varying(20) NOT NULL,
    team_id numeric NOT NULL,
    status numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    invitation_guid character varying(256) NOT NULL
);


--
