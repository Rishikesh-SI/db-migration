-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_forgot_pwd
-- Type: TABLE

-- Name: zeven_user_forgot_pwd; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_user_forgot_pwd (
    zeven_user_forgot_pwdid numeric(10,0) NOT NULL,
    user_id numeric NOT NULL,
    is_link_used numeric(1,0),
    created_date timestamp(0) without time zone DEFAULT now(),
    updated_date timestamp(0) without time zone DEFAULT now()
);


--
