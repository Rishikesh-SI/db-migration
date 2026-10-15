-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labkc_contact scom_contact_id; Type: CONSTRAINT; Schema: labkc; Owner: -
--

ALTER TABLE ONLY labkc.labkc_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
