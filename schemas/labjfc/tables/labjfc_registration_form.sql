-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_registration_form
-- Type: TABLE

-- Name: labjfc_registration_form; Type: TABLE; Schema: labjfc; Owner: -
--

CREATE TABLE labjfc.labjfc_registration_form (
    registration_form_id numeric NOT NULL,
    labjfc_gr_pin character varying(100),
    name character varying(300) NOT NULL,
    date_of_birth timestamp without time zone,
    certificate_no character varying(100),
    passport_aadhar_no character varying(100),
    age_group character varying(100),
    blood_group character varying(20),
    player_school character varying,
    coach_employed character varying(500),
    is_child_insured numeric,
    mother_name character varying(300),
    mother_contact_no character varying(20),
    father_name character varying(300),
    father_contact_no character varying(20),
    address character varying(4000),
    email_id character varying(500),
    medical_history text,
    registration_date timestamp without time zone,
    registration_type character varying(20),
    image_path character varying(4000),
    parent_signature character varying(4000),
    grassroots_manager_signature character varying(4000),
    indemnity_clause text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
