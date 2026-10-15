-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_forget_password
-- Type: TABLE

-- Name: pbl_forget_password; Type: TABLE; Schema: pbl; Owner: -
--

CREATE TABLE pbl.pbl_forget_password (
    forget_password_id numeric NOT NULL,
    user_id numeric NOT NULL,
    email_id character varying(300) NOT NULL,
    reset_key_guid character varying(256) NOT NULL,
    key_expiry_date timestamp without time zone NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL
);


--
