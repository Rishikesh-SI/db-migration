-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labctkr_contact scom_contact_id; Type: CONSTRAINT; Schema: labctkr; Owner: -
--

ALTER TABLE ONLY labctkr.labctkr_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
