-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labgt01_v1_contact scom_contact_id; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
