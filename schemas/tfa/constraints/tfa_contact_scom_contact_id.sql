-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: tfa_contact scom_contact_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
