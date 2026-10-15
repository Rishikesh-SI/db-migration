-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labhkind_contact scom_contact_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
