-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labstrd_contact scom_contact_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
