-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: tsk_contact scom_contact_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
