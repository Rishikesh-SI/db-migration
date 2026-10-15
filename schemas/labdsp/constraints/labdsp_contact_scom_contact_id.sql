-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labdsp_contact scom_contact_id; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
