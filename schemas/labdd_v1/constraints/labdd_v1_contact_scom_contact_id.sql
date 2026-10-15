-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labdd_v1_contact scom_contact_id; Type: CONSTRAINT; Schema: labdd_v1; Owner: -
--

ALTER TABLE ONLY labdd_v1.labdd_v1_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
