-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_training_programbk_29032019
-- Type: TABLE

-- Name: tmmimg_upd_training_programbk_29032019; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_training_programbk_29032019 (
    training_program_id numeric,
    name text,
    age numeric,
    gender character varying(200),
    dob timestamp without time zone,
    best_event_date timestamp without time zone,
    best_event_time text,
    best_event_name text,
    email_id character varying(2000),
    phone_number text,
    pdf_flag numeric,
    pdf_category text,
    pdf_path text,
    running_group jsonb,
    category_flag numeric,
    category text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    address character varying(4000),
    pincode character varying(10),
    occupation character varying(200),
    designation character varying(200),
    emergency_contact_name character varying(200),
    emergency_contactno character varying(20)
);


--
