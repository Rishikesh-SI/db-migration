-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labgfg_contact scom_contact_id; Type: CONSTRAINT; Schema: labgfg; Owner: -
--

ALTER TABLE ONLY labgfg.labgfg_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
