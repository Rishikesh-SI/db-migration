-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labstmp_contact scom_contact_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
