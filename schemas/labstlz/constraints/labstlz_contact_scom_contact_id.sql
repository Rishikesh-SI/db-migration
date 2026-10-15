-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labstlz_contact scom_contact_id; Type: CONSTRAINT; Schema: labstlz; Owner: -
--

ALTER TABLE ONLY labstlz.labstlz_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
