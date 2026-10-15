-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_daily_login
-- Type: TABLE

-- Name: zeven_user_daily_login; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_user_daily_login (
    user_daily_loginid numeric NOT NULL,
    userid numeric NOT NULL,
    login_date timestamp(0) without time zone DEFAULT now()
);


--
