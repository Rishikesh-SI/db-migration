-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labgsoc_contact scom_contact_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
