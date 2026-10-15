-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_deleted_membership_data
-- Type: TABLE

-- Name: labmi_v1_deleted_membership_data; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_deleted_membership_data (
    user_guid text,
    invoice_id text,
    total_price numeric,
    membership_date timestamp without time zone,
    user_deleted_date timestamp without time zone
);


--
