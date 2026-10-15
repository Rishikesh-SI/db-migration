-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labecn_contact scom_contact_id; Type: CONSTRAINT; Schema: labecn; Owner: -
--

ALTER TABLE ONLY labecn.labecn_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
