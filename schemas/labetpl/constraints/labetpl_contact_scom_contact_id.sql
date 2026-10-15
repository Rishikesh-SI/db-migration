-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labetpl_contact scom_contact_id; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
