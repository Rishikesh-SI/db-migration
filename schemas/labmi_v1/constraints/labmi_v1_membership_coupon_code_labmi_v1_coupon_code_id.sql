-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_membership_coupon_code labmi_v1_coupon_code_id
-- Type: CONSTRAINT

-- Name: labmi_v1_membership_coupon_code labmi_v1_coupon_code_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_membership_coupon_code
    ADD CONSTRAINT labmi_v1_coupon_code_id PRIMARY KEY (coupon_code_id);


--
