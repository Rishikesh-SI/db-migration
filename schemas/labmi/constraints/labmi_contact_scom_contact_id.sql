-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labmi_contact scom_contact_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
