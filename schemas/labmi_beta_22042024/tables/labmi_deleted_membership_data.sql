-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_deleted_membership_data
-- Type: TABLE

-- Name: labmi_deleted_membership_data; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_deleted_membership_data (
    user_guid text,
    invoice_id text,
    order_status character varying,
    total_price numeric,
    membership_date timestamp without time zone,
    user_deleted_date timestamp without time zone
);


--
