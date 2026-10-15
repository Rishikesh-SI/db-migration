-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labbsc_contact scom_contact_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
