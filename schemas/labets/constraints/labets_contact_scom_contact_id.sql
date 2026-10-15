-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labets_contact scom_contact_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
