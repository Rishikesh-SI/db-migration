-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_membership_data_temp
-- Type: TABLE

-- Name: labmi_v1_membership_data_temp; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_membership_data_temp (
    old text,
    new text,
    user_created_date timestamp without time zone,
    membership_created_date timestamp without time zone,
    old_no numeric,
    new_no numeric
);


--
