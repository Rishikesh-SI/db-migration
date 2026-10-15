-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labpr_contact scom_contact_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
