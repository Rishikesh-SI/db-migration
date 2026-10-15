-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labdsg_contact scom_contact_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
