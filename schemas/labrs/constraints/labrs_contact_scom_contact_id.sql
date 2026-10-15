-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labrs_contact scom_contact_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
