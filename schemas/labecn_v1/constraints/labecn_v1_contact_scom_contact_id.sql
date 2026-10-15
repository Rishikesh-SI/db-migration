-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labecn_v1_contact scom_contact_id; Type: CONSTRAINT; Schema: labecn_v1; Owner: -
--

ALTER TABLE ONLY labecn_v1.labecn_v1_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
