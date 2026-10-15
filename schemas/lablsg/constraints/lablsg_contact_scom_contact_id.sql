-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: lablsg_contact scom_contact_id; Type: CONSTRAINT; Schema: lablsg; Owner: -
--

ALTER TABLE ONLY lablsg.lablsg_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
