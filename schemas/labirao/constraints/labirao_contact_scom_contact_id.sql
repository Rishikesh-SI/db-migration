-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labirao_contact scom_contact_id; Type: CONSTRAINT; Schema: labirao; Owner: -
--

ALTER TABLE ONLY labirao.labirao_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
