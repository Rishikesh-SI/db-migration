-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labsrk_contact scom_contact_id; Type: CONSTRAINT; Schema: labsrk; Owner: -
--

ALTER TABLE ONLY labsrk.labsrk_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
