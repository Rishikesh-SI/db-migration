-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_membership_coupon_code labmi_coupon_code_id
-- Type: CONSTRAINT

-- Name: labmi_membership_coupon_code labmi_coupon_code_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_membership_coupon_code
    ADD CONSTRAINT labmi_coupon_code_id PRIMARY KEY (coupon_code_id);


--
