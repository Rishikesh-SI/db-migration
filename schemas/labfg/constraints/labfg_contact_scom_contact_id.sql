-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labfg_contact scom_contact_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
