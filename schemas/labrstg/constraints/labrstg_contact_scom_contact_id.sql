-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labrstg_contact scom_contact_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
