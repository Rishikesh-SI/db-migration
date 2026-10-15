-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_contact labwf_contact_email_address_unique
-- Type: CONSTRAINT

-- Name: labwf_contact labwf_contact_email_address_unique; Type: CONSTRAINT; Schema: fanxp_wf; Owner: -
--

ALTER TABLE ONLY fanxp_wf.labwf_contact
    ADD CONSTRAINT labwf_contact_email_address_unique UNIQUE (email_address);


--
