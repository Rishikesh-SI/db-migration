-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labadkr_contact scom_contact_id; Type: CONSTRAINT; Schema: labadkr; Owner: -
--

ALTER TABLE ONLY labadkr.labadkr_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
