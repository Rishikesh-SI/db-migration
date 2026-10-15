-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labpvl_contact scom_contact_id; Type: CONSTRAINT; Schema: labpvl; Owner: -
--

ALTER TABLE ONLY labpvl.labpvl_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
