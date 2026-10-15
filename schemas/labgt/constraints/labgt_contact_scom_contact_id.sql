-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labgt_contact scom_contact_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
