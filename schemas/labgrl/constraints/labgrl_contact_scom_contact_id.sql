-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labgrl_contact scom_contact_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
